Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A80A785C71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjHWPrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjHWPrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:47:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4322AE52
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:47:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B00D820906;
        Wed, 23 Aug 2023 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692805648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yon7qxBDLFnBXgKAsSaVBsa3rXFAPSE2gKqBEhqBxa4=;
        b=m/Rutyao5Bm1E61PJHAl1JaGFGKc5PfNRiwF2ObK9oI8kxB2PstBiucoDnaA23aJqmOfw/
        Qlr+gSl+tUYjyWbW0EE9aiSj/yFflFMmKpVJq5kRDqE3qQ6hBo/3rzOHs+h1b/MS8LC7Od
        zX7R6KDcxbjrLmkn4Har/sq59BVkiTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692805648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yon7qxBDLFnBXgKAsSaVBsa3rXFAPSE2gKqBEhqBxa4=;
        b=DR/w1bq7MLKt8StQ59fHmQnP4WQWAKFxxDSWsq6pifLVtCBX1fMbWKOOZdFxJkIoLSqoi/
        uTJo46zCoExxM2CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FCDA13458;
        Wed, 23 Aug 2023 15:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o4/3JhAq5mRaMwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 15:47:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 397F2A0774; Wed, 23 Aug 2023 17:47:28 +0200 (CEST)
Date:   Wed, 23 Aug 2023 17:47:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
Message-ID: <20230823154728.rpkw6fpwvwqbnnh3@quack3>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <ZOPSEJTzrow8YFix@snowbird>
 <20230821213951.bx3yyqh7omdvpyae@f>
 <CAGudoHHJECp2-DfSr5hudooAdV6mivvSO+4mC9kwUrWnSiob5g@mail.gmail.com>
 <20230822095154.7cr5ofogw552z3jk@quack3>
 <CAGudoHHe5nzRTuj4G1fphD+JJ02TE5BnHEDwFm=-W6DoEj2qVQ@mail.gmail.com>
 <20230823094915.ggv3spzevgyoov6i@quack3>
 <CAGudoHFFt5wvYWrwNkz813KaXBmROJ7YJ67s1h3_CBgcoV2fCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFFt5wvYWrwNkz813KaXBmROJ7YJ67s1h3_CBgcoV2fCA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-08-23 14:13:20, Mateusz Guzik wrote:
> On 8/23/23, Jan Kara <jack@suse.cz> wrote:
> > On Tue 22-08-23 16:24:56, Mateusz Guzik wrote:
> >> On 8/22/23, Jan Kara <jack@suse.cz> wrote:
> >> Then for single-threaded case an area is allocated for NR_MM_COUNTERS
> >> countes * 2 -- first set updated without any synchro by current
> >> thread. Second set only to be modified by others and protected with
> >> mm->arg_lock. The lock protects remote access to the union to begin
> >> with.
> >
> > arg_lock seems a bit like a hack. How is it related to rss_stat? The scheme
> > with two counters is clever but I'm not 100% convinced the complexity is
> > really worth it. I'm not sure the overhead of always using an atomic
> > counter would really be measurable as atomic counter ops in local CPU cache
> > tend to be cheap. Did you try to measure the difference?
> >
> 
> arg_lock is not as is, it would have to be renamed to something more generic.

Ah, OK.

> Atomics on x86-64 are very expensive to this very day. Here is a
> sample measurement of 2 atomics showing up done by someone else:
> https://lore.kernel.org/oe-lkp/202308141149.d38fdf91-oliver.sang@intel.com/T/#u
> 
> tl;dr it is *really* bad.

I didn't express myself well. Sure atomics are expensive compared to plain
arithmetic operations. But I wanted to say - we had atomics for RSS
counters before commit f1a7941243 ("mm: convert mm's rss stats into
percpu_counter") and people seemed happy with it until there were many CPUs
contending on the updates. So maybe RSS counters aren't used heavily enough
for the difference to practically matter? Probably operation like faulting
in (or unmapping) tmpfs file has the highest chance of showing the cost of
rss accounting compared to the cost of the remainder of the operation...

> > If the second counter proves to be worth it, we could make just that one
> > atomic to avoid the need for abusing some spinlock.
> 
> The spinlock would be there to synchronize against the transition to
> per-cpu -- any trickery is avoided and we trivially know for a fact
> the remote party either sees the per-cpu state if transitioned, or
> local if not. Then one easily knows no updates have been lost and the
> buf for 2 sets of counters can be safely freed.

Yeah, the spinlock makes the transition simpler, I agree.

> While writing down the idea previously I did not realize the per-cpu
> counter ops disable interrupts around the op. That's already very slow
> and the trip should be comparable to paying for an atomic (as in the
> patch which introduced percpu counters here slowed things down for
> single-threaded processes).
> 
> With your proposal the atomic would be there, but interrupt trip could
> be avoided. This would roughly maintain the current cost of doing the
> op (as in it would not get /worse/). My patch would make it lower.
> 
> All that said, I'm going to refrain from writing a patch for the time
> being. If powers to be decide on your approach, I'm not going to argue
> -- I don't think either is a clear winner over the other.

I guess we'll need to code it and compare the results :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
