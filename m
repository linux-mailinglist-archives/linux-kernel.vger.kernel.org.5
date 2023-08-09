Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59F2776605
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjHIRDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjHIRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09A2689
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691600556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iBsxuYSh5nCvyR3EDZMX/GoLNC8vGSJmNwZKjotP104=;
        b=apVNHLRRg067vqaXiq9LGyB490ikLKiPbJSZjpuVU/XRKSZafBCeRC54ZWGIN0nlh9+5J3
        XA/eWJcoV4U4r9ISpDIMICnjWrubj/mbwAre4FvbIfpC/aS/5d8e33rxi6P4iDjKbM4Hmy
        K/hq3xYSqN4yCgrH0diJ8E0v7lmYQfA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-LrzU9ZULN0CQB5CyWfpzlQ-1; Wed, 09 Aug 2023 13:02:35 -0400
X-MC-Unique: LrzU9ZULN0CQB5CyWfpzlQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe1bef4223so43271325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600554; x=1692205354;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iBsxuYSh5nCvyR3EDZMX/GoLNC8vGSJmNwZKjotP104=;
        b=H9ppIG7ngVwIWuDPKBoQ4Xn1rTwfX0JnKgqgCAfoWZ8tonXR5QBNzBRvOpJnCbXZwB
         3RKnwh3JlIQlBavcMjMxfGajlcK0q42crXcko+48fpA3vrb1DtrtBZhJNtfmAE/wDFie
         YGEzwFsdFXRh5/Io9Fys2mkGdS4bxG3inoEI185rZEb4m6f0wvngKEM+3+Hlot0pqXEU
         pg6T+DdUArGrUHfVgSR7j5FNWhQLdvVBuOMqieHUCu7oFR6xeK81AQnp6DJqcwnLsZ0B
         UYXArvEryRsVwrFaiyvMBXzV4zlxgio97PsxoLOdI9opod1oAck7dtqljTtu5lHn5Nr0
         9u6Q==
X-Gm-Message-State: AOJu0YwS5pJuUmGV96KT8W6xTtj6KUBi347U9Yzhf9qymLHC0vgucTWe
        m0wNNMu3eplIHuKL6mJt3YLTIqYRgTJQGBKwR0xRsyHy4cyMVHSWwgGzPoOV2vOs9wEwpgWGOjw
        MXmXgKVxzfVlj2MhzXnmt58sZ
X-Received: by 2002:a05:600c:204b:b0:3fe:16f4:d865 with SMTP id p11-20020a05600c204b00b003fe16f4d865mr2542946wmg.23.1691600554087;
        Wed, 09 Aug 2023 10:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIgHp10Cy37KFuMxkg6Q8lraqrygcVUIRlfj8D2iI402kzJUIV27FmCS9jAnnaF/QZEmDB/Q==
X-Received: by 2002:a05:600c:204b:b0:3fe:16f4:d865 with SMTP id p11-20020a05600c204b00b003fe16f4d865mr2542931wmg.23.1691600553761;
        Wed, 09 Aug 2023 10:02:33 -0700 (PDT)
Received: from vschneid.remote.csb ([93.186.150.163])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bcd18000000b003fba6709c68sm2494886wmj.47.2023.08.09.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 10:02:33 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/rt: Don't try push tasks if there are none.
In-Reply-To: <20230801152648._y603AS_@linutronix.de>
References: <20230801152648._y603AS_@linutronix.de>
Date:   Wed, 09 Aug 2023 18:02:32 +0100
Message-ID: <xhsmhv8dob13r.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/23 17:26, Sebastian Andrzej Siewior wrote:
> I have a RT task X at a high priority and cyclictest on each CPU with
> lower priority than X's. If X is active and each CPU wakes their own
> cylictest thread then it ends in a longer rto_push storm.
> A random CPU determines via balance_rt() that the CPU on which X is
> running needs to push tasks. X has the highest priority, cyclictest is
> next in line so there is nothing that can be done since the task with
> the higher priority is not touched.
>
> tell_cpu_to_push() increments rto_loop_next and schedules
> rto_push_irq_work_func() on X's CPU. The other CPUs also increment the
> loop counter and do the same. Once rto_push_irq_work_func() is active it
> does nothing because it has _no_ pushable tasks on its runqueue. Then
> checks rto_next_cpu() and decides to queue irq_work on the local CPU
> because another CPU requested a push by incrementing the counter.
>

For a CPU to be in the rto_mask, it needs:

  rt_rq->rt_nr_migratory && rt_rq->rt_nr_total > 1

But if that CPU has no pushable tasks, then that means only the current
task has p->nr_cpus_allowed > 1.

Should we change it so a CPU is only in the rto_mask iff it has pushable
tasks? AFAICT that should not break the case where we push the current task
away due to migration_disabled, as that still relies on the
migration_disabled task to be in the pushable list.

