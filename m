Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3058E775F04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjHIMbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHIMbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:31:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A110F3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:31:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so9644415a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691584300; x=1692189100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovz1LQ6CtkIwOn2X9qPamiwiMkn0NFocCNlrpAkV6FE=;
        b=z87ipBGX3qL/8LN9fCqtHDrLvXwt7S+tuWniA0tiSN+CNh6VbxxtBmQyhlh+HSLCWN
         MokZhrhhkDyQWUhh9ddK3revJvWDVvj2sxHC4KXjeDpHTshiyAuc70hwHoBgd0D3IuBu
         5k9b808R7uSlBLTvoexBmRyAkLz6yt2iieSuBEiwwYnarzGFdq2UbjWDrhJYDGYDKrzU
         Ngn0OvDY/ASZZNoBb+Po1N546t3BYGJ/Kndgkbj6cNDyIWWYTuWeiikDfIujTd9k81IP
         ioqXYMTlg8TrKl0DP1iGK/J5PrbeS+eADjISSm/JLbcsqPhfWZABOt3x9Ej67B+2ocPB
         8qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691584300; x=1692189100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovz1LQ6CtkIwOn2X9qPamiwiMkn0NFocCNlrpAkV6FE=;
        b=gxwJq/2EYXMHXZjLJ8d/KIaoXFWALqB8iZIeyMXxyyWp0J6i71jTL5Fx/U3wDUWhkW
         RNaVa88z4XawltuD8b9Qz5f/RMz6XLJARPslgLfee7siI5AbVV+tzeZgQYW6mrGz6NwA
         57XRmz0My3wb3QzcU0Edj82++6hYRK8/C3Z6YF9pMTeCM9mHJ6Zz7DNU/yJ/AKKhTG44
         I6pBxqnTQi30aOYGPW46eywOOXjG044wW9d18wtkQLZMFHnO8SWSYqTWd+4EmXZAHW9Z
         hZjbIiSUcUI0WsCC9rhcZ1ZBVTEGKOEHKHeCzS/IOnZet+E2PSVTr3xY/HjZX9DENS3F
         7tkA==
X-Gm-Message-State: AOJu0YzNYRkh22ys1MtBkOmy3pwx587twXV3GlVeuctQ+J8U0wnBIqmQ
        Lv8J1EsJ/4mHzuH90MQs59DeEAWJNjN6LDzjG5cU3w==
X-Google-Smtp-Source: AGHT+IF/mGXH5UfrJX6nELy6/81vEx+XhPbo08yywYMlK/WQ2uPYFAWUssEQqHCxlyDePoNGc3wEnaAzdkQ+vNM8KCw=
X-Received: by 2002:a17:906:738d:b0:99c:ac84:663b with SMTP id
 f13-20020a170906738d00b0099cac84663bmr2069551ejl.65.1691584300324; Wed, 09
 Aug 2023 05:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com> <ZNNTgZVPZipTL/UM@dhcp22.suse.cz>
In-Reply-To: <ZNNTgZVPZipTL/UM@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 9 Aug 2023 05:31:04 -0700
Message-ID: <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 1:51=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 09-08-23 04:58:10, Yosry Ahmed wrote:
> > Over time, the memcg code added multiple optimizations to the stats
> > flushing path that introduce a tradeoff between accuracy and
> > performance. In some contexts (e.g. dirty throttling, refaults, etc), a
> > full rstat flush of the stats in the tree can be too expensive. Such
> > optimizations include [1]:
> > (a) Introducing a periodic background flusher to keep the size of the
> > update tree from growing unbounded.
> > (b) Allowing only one thread to flush at a time, and other concurrent
> > flushers just skip the flush. This avoids a thundering herd problem
> > when multiple reclaim/refault threads attempt to flush the stats at
> > once.
> > (c) Only executing a flush if the magnitude of the stats updates exceed=
s
> > a certain threshold.
> >
> > These optimizations were necessary to make flushing feasible in
> > performance-critical paths, and they come at the cost of some accuracy
> > that we choose to live without. On the other hand, for flushes invoked
> > when userspace is reading the stats, the tradeoff is less appealing
> > This code path is not performance-critical, and the inaccuracies can
> > affect userspace behavior. For example, skipping flushing when there is
> > another ongoing flush is essentially a coin flip. We don't know if the
> > ongoing flush is done with the subtree of interest or not.
>
> I am not convinced by this much TBH. What kind of precision do you
> really need and how much off is what we provide?
>
> More expensive read of stats from userspace is quite easy to notice
> and usually reported as a regression. So you should have a convincing
> argument that an extra time spent is really worth it. AFAIK there are
> many monitoring (top like) tools which simply read those files regularly
> just to show numbers and they certainly do not need a high level of
> precision.

We used to spend this time before commit fd25a9e0e23b ("memcg: unify
memcg stat flushing") which generalized the "skip if ongoing flush"
for all stat flushing. As far I know, the problem was contention on
the flushing lock which also affected critical paths like refault.

The problem is that the current behavior is indeterministic, if cpu A
tries to flush stats and cpu B is already doing that, cpu A will just
skip. At that point, the cgroup(s) that cpu A cares about may have
been fully flushed, partially flushed (in terms of cpus), or not
flushed at all. We have no idea. We just know that someone else is
flushing something. IOW, in some cases the flush request will be
completely ignored and userspace will read stale stats (up to 2s + the
periodic flusher runtime).

Some workloads need to read up-to-date stats as feedback to actions
(e.g. after proactive reclaim, or for userspace OOM killing purposes),
and reading such stale stats causes regressions or misbehavior by
userspace.

>
> [...]
> > @@ -639,17 +639,24 @@ static inline void memcg_rstat_updated(struct mem=
_cgroup *memcg, int val)
> >       }
> >  }
> >
> > -static void do_flush_stats(void)
> > +static void do_flush_stats(bool full)
> >  {
> > +     if (!atomic_read(&stats_flush_ongoing) &&
> > +         !atomic_xchg(&stats_flush_ongoing, 1))
> > +             goto flush;
> > +
> >       /*
> > -      * We always flush the entire tree, so concurrent flushers can ju=
st
> > -      * skip. This avoids a thundering herd problem on the rstat globa=
l lock
> > -      * from memcg flushers (e.g. reclaim, refault, etc).
> > +      * We always flush the entire tree, so concurrent flushers can ch=
oose to
> > +      * skip if accuracy is not critical. Otherwise, wait for the ongo=
ing
> > +      * flush to complete. This avoids a thundering herd problem on th=
e rstat
> > +      * global lock from memcg flushers (e.g. reclaim, refault, etc).
> >        */
> > -     if (atomic_read(&stats_flush_ongoing) ||
> > -         atomic_xchg(&stats_flush_ongoing, 1))
> > -             return;
> > -
> > +     while (full && atomic_read(&stats_flush_ongoing) =3D=3D 1) {
> > +             if (!cond_resched())
> > +                     cpu_relax();
>
> You are reinveting a mutex with spinning waiter. Why don't you simply
> make stats_flush_ongoing a real mutex and make use try_lock for !full
> flush and normal lock otherwise?

So that was actually a spinlock at one point, when we used to skip if
try_lock failed. We opted for an atomic because the lock was only used
in a try_lock fashion. The problem here is that the atomic is used to
ensure that only one thread actually attempts to flush at a time (and
others skip/wait), to avoid a thundering herd problem on
cgroup_rstat_lock.

Here, what I am trying to do is essentially equivalent to "wait until
the lock is available but don't grab it". If we make
stats_flush_ongoing a mutex, I am afraid the thundering herd problem
will be reintroduced for stats_flush_ongoing this time.

I am not sure if there's a cleaner way of doing this, but I am
certainly open for suggestions. I also don't like how the spinning
loop looks as of now.
