Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F5787C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 02:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjHYA1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 20:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjHYA1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 20:27:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BC0172D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 17:26:57 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so136081cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 17:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692923216; x=1693528016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE/ztH2CwgACZMdtKdLIrzyQq3XwqfUPfcUgZae1/tY=;
        b=HMLwfExOUEm0eHZm+mdNFpcqy472UOfiT4r19OayyzYi8yvtkqg76227NHCgEmoIYY
         U9ox956Ojq6JCQVYzKx6wQL8k4kDQSqCHivmJQUJiWFcKtycEFnydCHK1m6Mtigb+uik
         B/vBchI88W242d14tr6ZlmO2sNVxbEaFMp3Dd5yBLXfUyCiL8T4ZXzzrmF6X0NK0r6+4
         M2lrdq8HEXHEBGDuUDkWKEbOXWbKotpZm7ERxh300qI7Q3O2GIIQ/5LQ0/twxtxzGV82
         uDl4jGM4viH04Q4W2nXfb3DbVE2vKkELkmraSRqDeDJ3EXJO5cuySAG3ffjGhn0Wt8Lx
         xPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692923216; x=1693528016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE/ztH2CwgACZMdtKdLIrzyQq3XwqfUPfcUgZae1/tY=;
        b=FO/+1KpzCfs4SgoOeUIHOfy4aEnzVHyAuqXkjVYuATZKZooOvuMBlCzCVbaqpEek1m
         haD5wXxJUbEzXS9ON2G7Im0WPVRoOSrcNg2Afc21Tv3axvweK9VtJNypBN53bv1iy7Ad
         bYVcCJL6MjFoDpgRtaGwkvbku4yIzw404GU59WTvVBaKOhJR8azhoGV/+zdC8tqFtq0l
         bZGpyJCCGVpMi1PYLzkNIwJKd3x1mmR2nUeFC9dAy9DmFlp6bVBMg8ac1mDItU1oV7w4
         5QiRCweuKEBfA1Te/J9Qr7jU9rLNroMeLV2Huj/m9RqE0QzzFlLfw7ZwmjN3UP18moC2
         k//w==
X-Gm-Message-State: AOJu0YwGp7SCC7ebDe3lgnoJFGD0quFKRLcVdPHYsCGfEGQ/k27eWIHK
        Pp7zAtCJjrBui4mGJJqkoXeNXSzwZDIdOSLOlVwOAQ==
X-Google-Smtp-Source: AGHT+IHNaFDpzxX5di1BodQif0JJ/0PqZnNj/F7MTdbPhlmXm/HwLRUe5zozWPARHwHHTJn4A1/5937WG8wrTThGrxM=
X-Received: by 2002:ac8:7d09:0:b0:410:a4cb:9045 with SMTP id
 g9-20020ac87d09000000b00410a4cb9045mr160249qtb.18.1692923216047; Thu, 24 Aug
 2023 17:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230711011412.100319-1-tj@kernel.org> <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
In-Reply-To: <ZLrQdTvzbmi5XFeq@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 24 Aug 2023 17:26:45 -0700
Message-ID: <CABk29Nt_iCv=2nbDUqFHnszMmDYNC7xEm1nNQXibnPKUxhsN_g@mail.gmail.com>
Subject: Re: [PATCHSET v4] sched: Implement BPF extensible scheduler class
To:     Tejun Heo <tj@kernel.org>, peterz@infradead.org
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Neel Natu <neelnatu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 21, 2023 at 11:37=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
[snip]
> We are comfortable with the current API. Everything we tried fit pretty
> well. It will continue to evolve but sched_ext now seems mature enough fo=
r
> initial inclusion. I suppose lack of response doesn't indicate tacit
> agreement from everyone, so what are you guys all thinking?

I want to reiterate Google=E2=80=99s support for this proposal.

We=E2=80=99ve been experimenting with pluggable scheduling via our ghOSt
framework (https://github.com/google/ghost-kernel) for quite a while
now. A few things have become clearly evident.

(1) There is a very non-trivial level of headroom that can be taken
advantage of by directed policy that more closely specializes to the
types of workloads deployed on a machine. I can provide two direct
examples.
In Search, the backend application has intimate knowledge of thread
workloads and RPC deadlines, which it immediately communicates to our
BPF scheduler via BPF maps. We've used this info to construct a policy
that reduces context switches, decreases p99 latency, and increases
QPS by 5% in testing. The flexibility of expressiveness in terms of
priority goes far beyond what niceness or cpu.shares could achieve.

For VM workloads, we=E2=80=99ve been testing a policy that has virtually
eliminated our >10ms latency tails via a combination of deadline and
fair scheduling, using an approach inspired by Tableau
(https://arpangujarati.github.io/pdfs/eurosys2018_paper.pdf). I find
this case particularly appealing from a pluggable scheduling
perspective because it highlights an area in which specialization to
the type of workload (VMs, which prefer longer, gang scheduled,
uninterrupted, and predictable low-latency access to CPU) provides
clear benefits, yet is not appropriate for a general-purpose scheduler
like CFS.

(2) Sched knobs are incredibly useful, and tuning has real effects.
The scheduler exports various debugfs knobs to control behavior, such
as minimum granularity, overall sched latency, and migration cost.
These mostly get baked into the kernel with semi-arbitrary values.
But, experimentally, it makes a lot of sense to (for example) lower
the migration cost on certain combinations of hardware and workload,
taking a tradeoff to increase migration rate but reduce non-work
conserving behavior.

We=E2=80=99ve taken this idea further with an ML based system to automatica=
lly
find the best combination of sched knobs for a given workload, given a
goal such as to maximize QPS. This has resulted in gains of 2-5%; a
lot of performance to leave on the table simply due to using preset
defaults. Pluggable scheduling would further increase the surface area
of experimentation, and yield additional insight into what other
kernel heuristics could be improved. It was from the ML work that we
gleaned that migrating tasks in smaller batches, but more frequently,
was a better tradeoff than the default configuration.

(3) There are a number of really interesting scheduling ideas that
would be difficult or infeasible to bake into the kernel. One clear
example is core scheduling, which was quite a complex addition to the
kernel (for example, due to managing fairness of tasks spanning the
logical cpus of a core), but which has relatively straightforward
implementation in sched_ext and ghOSt (for example, in ghOSt, a single
cpu can issue a transaction to run tasks on both itself and its
sibling, achieving the needed security property of core scheduling.
Fairness follows easily because runqueues can easily be any shape in
userspace, such as per-core.).
Another interesting idea is to offload scheduling entirely from VM
cores in order to keep ticks stopped with NOHZ independent of the task
count, since preemptive scheduling can be driven by a remote core.


Moving forward, we=E2=80=99re planning to redesign our ghOSt userspace
infrastructure to work on top of the sched_ext kernel infrastructure.
We think there=E2=80=99s a lot of benefit to the sched_ext design, especial=
ly
the very tight BPF integration. We=E2=80=99re committed to the idea of
pluggable scheduling, and are in close collaboration with Meta to
advance this work while we simultaneously deploy it internally.

Best,
Josh
