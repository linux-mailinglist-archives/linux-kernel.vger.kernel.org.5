Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC68786B76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjHXJUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240716AbjHXJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:20:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB219A0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:19:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 665C522D43;
        Thu, 24 Aug 2023 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692868797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RGP9xeav/e3xVesZmYKSwuX1TjnqIVlXGjw9+5yUF0=;
        b=1JIHW9nydfiEN87mKuDeM/2onAxv3w6VzwVB4kz0YQtV9FLdnj+zEWgQ0TWOhpXuaxzgaw
        dtDGQdcopESva3h/gaUGp1hYDD1o5uNxpR6/c9jHgIz/KO0rNzJ+28Ei4nSuaDQqujG6u1
        81YFi0XVK6lPjGJ3enJ/7ldLr+XtXxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692868797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RGP9xeav/e3xVesZmYKSwuX1TjnqIVlXGjw9+5yUF0=;
        b=2eEqiSkDdoa256MB0dclCNlzp37VVhXaRkQg8BqhmwDYcl3CxBgg4mY9r656Gy/I1sofCh
        1j3srpdHXZzAG7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52038132F2;
        Thu, 24 Aug 2023 09:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9kP5E70g52QLEgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Aug 2023 09:19:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CCF15A0774; Thu, 24 Aug 2023 11:19:56 +0200 (CEST)
Date:   Thu, 24 Aug 2023 11:19:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>,
        linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
Message-ID: <20230824091956.drn6ucixj4qbxwa7@quack3>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f>
 <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3>
 <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
 <20230823094915.ggv3spzevgyoov6i@quack3>
 <ZOZrzG/MgL8vw+lI@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOZrzG/MgL8vw+lI@snowbird>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-08-23 13:27:56, Dennis Zhou wrote:
> On Wed, Aug 23, 2023 at 11:49:15AM +0200, Jan Kara wrote:
> > On Tue 22-08-23 16:24:56, Mateusz Guzik wrote:
> > > On 8/22/23, Jan Kara <jack@suse.cz> wrote:
> > > > On Tue 22-08-23 00:29:49, Mateusz Guzik wrote:
> > > >> On 8/21/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > > >> > True Fix(tm) is a longer story.
> > > >> >
> > > >> > Maybe let's sort out this patchset first, whichever way. :)
> > > >> >
> > > >>
> > > >> So I found the discussion around the original patch with a perf
> > > >> regression report.
> > > >>
> > > >> https://lore.kernel.org/linux-mm/20230608111408.s2minsenlcjow7q3@quack3/
> > > >>
> > > >> The reporter suggests dodging the problem by only allocating per-cpu
> > > >> counters when the process is going multithreaded. Given that there is
> > > >> still plenty of forever single-threaded procs out there I think that's
> > > >> does sound like a great plan regardless of what happens with this
> > > >> patchset.
> > > >>
> > > >> Almost all access is already done using dedicated routines, so this
> > > >> should be an afternoon churn to sort out, unless I missed a
> > > >> showstopper. (maybe there is no good place to stuff a flag/whatever
> > > >> other indicator about the state of counters?)
> > > >>
> > > >> That said I'll look into it some time this or next week.
> > > >
> > > > Good, just let me know how it went, I also wanted to start looking into
> > > > this to come up with some concrete patches :). What I had in mind was that
> > > > we could use 'counters == NULL' as an indication that the counter is still
> > > > in 'single counter mode'.
> > > >
> > > 
> > > In the current state there are only pointers to counters in mm_struct
> > > and there is no storage for them in task_struct. So I don't think
> > > merely null-checking the per-cpu stuff is going to cut it -- where
> > > should the single-threaded counters land?
> > 
> > I think you misunderstood. What I wanted to do it to provide a new flavor
> > of percpu_counter (sharing most of code and definitions) which would have
> > an option to start as simple counter (indicated by pcc->counters == NULL
> > and using pcc->count for counting) and then be upgraded by a call to real
> > percpu thing. Because I think such counters would be useful also on other
> > occasions than as rss counters.
> > 
> 
> Kent wrote something similar and sent it out last year [1]. However, the
> case slightly differs from what we'd want here, 1 -> 2 threads becomes
> percpu vs update rate which a single thread might be able to trigger?

Thanks for the pointer but that version of counters is not really suitable
here as is (but we could factor out some common bits if that work is
happening). 1 thread can easily do 10000 RSS updates per second.

> [1] https://lore.kernel.org/lkml/20230501165450.15352-8-surenb@google.com/

								Honza

> > > Bonus problem, non-current can modify these counters and this needs to
> > > be safe against current playing with them at the same time. (and it
> > > would be a shame to require current to use atomic on them)
> > 
> > Hum, I didn't realize that. Indeed I can see that e.g. khugepaged can be
> > modifying the counters for other processes. Thanks for pointing this out.
> > 
> > > That said, my initial proposal adds a union:
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 5e74ce4a28cd..ea70f0c08286 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -737,7 +737,11 @@ struct mm_struct {
> > > 
> > >                 unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for
> > > /proc/PID/auxv */
> > > 
> > > -               struct percpu_counter rss_stat[NR_MM_COUNTERS];
> > > +               union {
> > > +                       struct percpu_counter rss_stat[NR_MM_COUNTERS];
> > > +                       u64 *rss_stat_single;
> > > +               };
> > > +               bool    magic_flag_stuffed_elsewhere;
> > > 
> > >                 struct linux_binfmt *binfmt;
> > > 
> > > 
> > > Then for single-threaded case an area is allocated for NR_MM_COUNTERS
> > > countes * 2 -- first set updated without any synchro by current
> > > thread. Second set only to be modified by others and protected with
> > > mm->arg_lock. The lock protects remote access to the union to begin
> > > with.
> > 
> > arg_lock seems a bit like a hack. How is it related to rss_stat? The scheme
> > with two counters is clever but I'm not 100% convinced the complexity is
> > really worth it. I'm not sure the overhead of always using an atomic
> > counter would really be measurable as atomic counter ops in local CPU cache
> > tend to be cheap. Did you try to measure the difference?
> > 
> > If the second counter proves to be worth it, we could make just that one
> > atomic to avoid the need for abusing some spinlock.
> > 
> > > Transition to per-CPU operation sets the magic flag (there is plenty
> > > of spare space in mm_struct, I'll find a good home for it without
> > > growing the struct). It would be a one-way street -- a process which
> > > gets a bunch of threads and goes back to one stays with per-CPU.
> > 
> > Agreed with switching to be a one-way street.
> > 
> > > Then you get the true value of something by adding both counters.
> > > 
> > > arg_lock is sparingly used, so remote ops are not expected to contend
> > > with anything. In fact their cost is going to go down since percpu
> > > summation takes a spinlock which also disables interrupts.
> > > 
> > > Local ops should be about the same in cost as they are right now.
> > > 
> > > I might have missed some detail in the above description, but I think
> > > the approach is decent.
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
