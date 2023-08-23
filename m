Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27559785D65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbjHWQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbjHWQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:41:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFC9A8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:41:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0E182095B;
        Wed, 23 Aug 2023 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692808876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BW7dUoeev2xy4pTa2DwHGhHYblYyga+z5up7jx4hMt8=;
        b=L+lhDXJTTwCjMnG1V3E8gPKdXlku9RCyowfjssYcX58/OxnSEaxu35BVxRT4wl82O7Cy2N
        D9zVsbT0YDJtFQpHjSvDDoKf9kSHDDVCjbNv3og9plp+CPG5WbkGAsTpB1NlKPhnwURq3F
        vuxdo5Lr/RESWXMBFjVLO0lyxZvLIVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692808876;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BW7dUoeev2xy4pTa2DwHGhHYblYyga+z5up7jx4hMt8=;
        b=l6FtSgNtSu23pB9LUXqChxXGNFyWm31qFn1Mh8QUjcegmIHdODp/WnFX/kLzYrGhlTSbJY
        bIBl/ak1MpkljpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC0661351F;
        Wed, 23 Aug 2023 16:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t5z4Kaw25mRwSgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 16:41:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 24FE3A0774; Wed, 23 Aug 2023 18:41:16 +0200 (CEST)
Date:   Wed, 23 Aug 2023 18:41:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
Message-ID: <20230823164116.aqjl6f5m2o3rwyxe@quack3>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f>
 <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3>
 <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
 <20230823094915.ggv3spzevgyoov6i@quack3>
 <CAGudoHFFt5wvYWrwNkz813KaXBmROJ7YJ67s1h3_CBgcoV2fCA@mail.gmail.com>
 <20230823154728.rpkw6fpwvwqbnnh3@quack3>
 <CAGudoHFvGwcQ+8JOjwR3B=KtHiVqC1=eiNgGv33z29443VJdFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFvGwcQ+8JOjwR3B=KtHiVqC1=eiNgGv33z29443VJdFg@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-08-23 18:10:29, Mateusz Guzik wrote:
> On 8/23/23, Jan Kara <jack@suse.cz> wrote:
> > I didn't express myself well. Sure atomics are expensive compared to plain
> > arithmetic operations. But I wanted to say - we had atomics for RSS
> > counters before commit f1a7941243 ("mm: convert mm's rss stats into
> > percpu_counter") and people seemed happy with it until there were many CPUs
> > contending on the updates. So maybe RSS counters aren't used heavily enough
> > for the difference to practically matter? Probably operation like faulting
> > in (or unmapping) tmpfs file has the highest chance of showing the cost of
> > rss accounting compared to the cost of the remainder of the operation...
> >
> 
> These stats used to be decentralized by storing them in task_struct,
> the commit complains about values deviating too much.
> 
> The value would get synced every 64 uses, from the diff:
> -/* sync counter once per 64 page faults */
> -#define TASK_RSS_EVENTS_THRESH (64)
> -static void check_sync_rss_stat(struct task_struct *task)
> -{
> -       if (unlikely(task != current))
> -               return;
> -       if (unlikely(task->rss_stat.events++ > TASK_RSS_EVENTS_THRESH))
> -               sync_mm_rss(task->mm);
> -}
> 
> other than that it was a non-atomic update in struct thread.
> 
> -static void add_mm_counter_fast(struct mm_struct *mm, int member, int val)
> -{
> -       struct task_struct *task = current;
> -
> -       if (likely(task->mm == mm))
> -               task->rss_stat.count[member] += val;
> -       else
> -               add_mm_counter(mm, member, val);
> -}

Ah, I see. I already forgot these details since I was checking the
regression back in spring. Now I've just seen the atomic_long_t counters in
task_struct and forgot there used to be also these per-thread ones. Thanks
for refreshing my memory!

> So the question is how much does this matter. My personal approach is
> that avoidable slowdowns (like atomics here) only facilitate further
> avoidable slowdowns as people can claim there is a minuscule change in
> % to baseline. But if the baseline is already slow....

I get your point but over the years I've also learned that premature
optimization isn't good either as we will be dragging the maintenance
burden for a long time ;) It's a balance.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
