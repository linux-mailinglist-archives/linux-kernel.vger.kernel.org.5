Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015FB768F76
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGaID1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 04:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjGaIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:02:59 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AD519AA;
        Mon, 31 Jul 2023 01:02:10 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-563393b63dbso351109eaf.1;
        Mon, 31 Jul 2023 01:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790529; x=1691395329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ijbOYA9unDh372iyvw22tAArTIXT8/U4ztbnRWjXnA=;
        b=Ygf1goRKuwnV/NaliCTWuqQZrUGuZ0YBOPyyFMb6bwaQiXGmHkRKQC6HGvSWYWaZ1n
         BUYmZOtld1Fn+6/ySpLnR8nnWJnQ20Zv67g8kiOxhj8PX/7ueYWv/jcmkytISg0fGy1G
         uxQudERHGLhXdjfSUkIS/VGpFZYir7tAzqYRtI6Z+ZZfIkNN8Ewf+YwqHdmq8ZJdVkXt
         kbEWAw05IcHjnVElrEnguwR5ck6iLkDGmQa75bz3CoLOlGHuhnk6Dz10qytnW7s9gNnB
         SHYKy13iJ/pmSMz/5/zWIkMDRLS6CZsFh3JuyD409HQMtliWZwVnG0PrxnGKeEWZFAXe
         siZA==
X-Gm-Message-State: ABy/qLYzN2btVjKwACCTLw3isZf/P2WevZmy2iZ3aQd3tKen7jmYt35R
        +zLAlX9rqTRDRR3TzDNOzHjD8EXUm/9c+vvfIZn/pHcL
X-Google-Smtp-Source: APBJJlG08Y08q8b9Lus5H0I1QRM2uR+ONK5q2Tr3OahnDyQZblTVplve571AQciGqfURZjIuNz5AjF6ECfGFtSIvx6M=
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id
 d5-20020a4aa585000000b0056c484a923dmr4497847oom.1.1690790529118; Mon, 31 Jul
 2023 01:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com> <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
In-Reply-To: <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jul 2023 10:01:53 +0200
Message-ID: <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, anna-maria@linutronix.de,
        tglx@linutronix.de, frederic@kernel.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 10:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 28, 2023 at 05:36:55PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > In order to facilitate governors that track history in idle-state
> > > buckets (TEO) making a useful decision about NOHZ, make sure we have a
> > > bucket that counts tick-and-longer.
> > >
> > > In order to be inclusive of the tick itself -- after all, if we do not
> > > disable NOHZ we'll sleep for a full tick, the actual boundary should
> > > be just short of a full tick.
> > >
> > > IOW, when registering the idle-states, add one that is always
> > > disabled, just to have a bucket.
> >
> > This extra bucket can be created in the governor itself, can't it?
>
> I couldn't find a nice spot for the governor to add idle-states.

Well, I've thought this through and recalled a couple of things and my
conclusion is that the decision whether or not to stop the tick really
depends on the idle state choice.

There are three cases:

1. The selected idle state is shallow (that is, its target residency
is below the tick period length), but it is not the deepest one.
2. The selected idle state is shallow, but it is the deepest one (or
at least the deepest enabled one).
3. The selected idle state is deep (that is, its target residency is
above the tick length period).

In case 1, the tick should not be stopped so as to prevent the CPU
from spending too much time in a suboptimal idle state.

In case 3, the tick needs to be stopped, because otherwise the target
residency of the selected state would not be met.

Case 2 is somewhat a mixed bag, but generally speaking stopping the
tick doesn't hurt if the selected idle state is the deepest one,
because in that case the governor kind of expects a significant exit
latency anyway.  If it is not the deepest one (which is disabled),
it's better to let the tick tick.
