Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658037AFD74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjI0IAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjI0IAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:00:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3DD11D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:00:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c93638322so2330953166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695801615; x=1696406415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nV6vVOxuvpJ4aTooRcfx52+uWH5cR86Wo4p6hinLqq4=;
        b=imQaO1OCO1Bu36Gbh6cQ4DkD1/YMos322YzXw2ymRIkCCnWarGdpK2SCPH4IQSu6Ib
         syv/PljQ3BxdkSFypoJkWZVpDvTSRz50IfiTClnSj9/KMH1NMhJgl7PTE/QK2CofPJeS
         xome/IjcZlp9rYfMUtNWvjWct+Z7+kearzwFrAJR1gKb1PzWY9Ke3saBNNQKvLJjkoM7
         oj0sScYCtM6BmbMWMdprlr1+V7AKDxb+SaNv3fcFwiaI1W/yqB6WwHWR70CaF4KOmmW7
         7c8kq8JVx/n/ehho1GA638zS/49HpLhpiHFoj9QKLmaBLU2UhEP97IoiFlQYjDFXv02F
         2Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695801615; x=1696406415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV6vVOxuvpJ4aTooRcfx52+uWH5cR86Wo4p6hinLqq4=;
        b=Pm3pmBhK5EQHXGG8h0Uu9+ugDRzYzpOHr4uJkvDHwwTxYhF4gJhe+3EVOpVr8iqrKt
         Au7KXwZV3cZy9ImzMTgaCwGSPKpPsEVyD1oESpDOETggzAK2UK5FSVZ9cBp5xxzwB76p
         DclIT919a8oY6QhSPiC26+g9lRjyXMTZcPtn2tlPMYcV2yI+5yTiyet25xXe3wNZwrdy
         iLXqAbmmvsA8jeTGQyaHbTPA1H9XBQ1E6YsPk3tPgnINJ0ILlEf65dQTaL8bn0ErKTid
         Can/Qra8dOJ7ET1nzljG8rh6IT8KM/uqreCm3LeEXOLle1GgwgyhOEnfdt39dXd/j9Gb
         EcRw==
X-Gm-Message-State: AOJu0YzxTS2mnQEH1OayiqGsY1W9Ky95YMwG03sWy2SJKg1kjCVGrDAZ
        93IWeNkmYxUi1GhpY5V1Hs8=
X-Google-Smtp-Source: AGHT+IEsoD5ayR0f5t+0kc82eTV+RIIqaSG8zNMq+uRgF99c+/U/vnaQwvlgW/QEXgZw/KPszIgxbg==
X-Received: by 2002:a17:906:99c7:b0:9b2:a783:3d0 with SMTP id s7-20020a17090699c700b009b2a78303d0mr4571087ejn.37.1695801615309;
        Wed, 27 Sep 2023 01:00:15 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906230900b00993004239a4sm8817491eja.215.2023.09.27.01.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:00:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 27 Sep 2023 10:00:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Message-ID: <ZRPhC7b6OT1uFtNE@gmail.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695704179.git.yu.c.chen@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen Yu <yu.c.chen@intel.com> wrote:

> When task p is woken up, the scheduler leverages select_idle_sibling()
> to find an idle CPU for it. p's previous CPU is usually a preference
> because it can improve cache locality. However in many cases, the
> previous CPU has already been taken by other wakees, thus p has to
> find another idle CPU.
> 
> Inhibit the task migration while keeping the work conservation of
> scheduler could benefit many workloads. Inspired by Mathieu's
> proposal to limit the task migration ratio[1], this patch considers
> the task average sleep duration. If the task is a short sleeping one,
> then tag its previous CPU as cache hot for a short while. During this
> reservation period, other wakees are not allowed to pick this idle CPU
> until a timeout. Later if the task is woken up again, it can find its
> previous CPU still idle, and choose it in select_idle_sibling().

Yeah, so I'm not convinced about this at this stage.

By allowing a task to basically hog a CPU after it has gone idle already,
however briefly, we reduce resource utilization efficiency for the sake
of singular benchmark workloads.

In a mixed environment the cost of leaving CPUs idle longer than necessary
will show up - and none of these benchmarks show that kind of side effect
and indirect overhead.

This feature would be a lot more convincing if it tried to measure overhead
in the pathological case, not the case it's been written for.

Thanks,

	Ingo
