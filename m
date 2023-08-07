Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA8771C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHGIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjHGIU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:20:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0601E171E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:20:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7687D1F460;
        Mon,  7 Aug 2023 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691396426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dHv+Q+zckl8kRXv8jZYiaBCAeHh0V9XrS6OghMZOl/8=;
        b=TpcC5MgYdb1YFBzo2cyT8b5I1+d31p+KNyDG3zYN3icX+h+/4/gQIVH/F1sOnx9Sym58YE
        dwdBmjl6C9k3yBN8c22mxXQcxzPvejbKejsk0c3vvOvO0cvueOPk8tdiJK/B4gRmM9mRSx
        PhF4yNPKpNkIoJbjJoXyh76vUMq0U1g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F7F513487;
        Mon,  7 Aug 2023 08:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZFQdCUqp0GTSfgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 07 Aug 2023 08:20:26 +0000
Date:   Mon, 7 Aug 2023 10:20:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <ZNCpSZvpw8xB83Om@dhcp22.suse.cz>
References: <20230626081254.XmorFrhs@linutronix.de>
 <ZJmkPuqpW-wQAyNz@alley>
 <a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp>
 <20230727151029.e_M9bi8N@linutronix.de>
 <b6ba16ce-4849-d32c-68fe-07a15aaf9d9c@I-love.SAKURA.ne.jp>
 <649fa1a7-4efd-8cc7-92c7-ac7944adc283@I-love.SAKURA.ne.jp>
 <ZMfETPzGfpPP7F79@dhcp22.suse.cz>
 <60d4dc52-9281-9266-4294-b514bd09e6e8@I-love.SAKURA.ne.jp>
 <ZMu+kn/g4idBcycV@dhcp22.suse.cz>
 <2505f6d3-5a10-49e7-960f-12c31a62a366@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2505f6d3-5a10-49e7-960f-12c31a62a366@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-08-23 22:27:22, Tetsuo Handa wrote:
> On 2023/08/03 23:49, Michal Hocko wrote:
> > On Thu 03-08-23 22:18:10, Tetsuo Handa wrote:
> >> On 2023/07/31 23:25, Michal Hocko wrote:
> >>> On Sat 29-07-23 20:05:43, Tetsuo Handa wrote:
> >>>> On 2023/07/29 14:31, Tetsuo Handa wrote:
> >>>>> On 2023/07/28 0:10, Sebastian Andrzej Siewior wrote:
> >>>>>> On 2023-06-28 21:14:16 [+0900], Tetsuo Handa wrote:
> >>>>>>>> Anyway, please do not do this change only because of printk().
> >>>>>>>> IMHO, the current ordering is more logical and the printk() problem
> >>>>>>>> should be solved another way.
> >>>>>>>
> >>>>>>> Then, since [PATCH 1/2] cannot be applied, [PATCH 2/2] is automatically
> >>>>>>> rejected.
> >>>>>>
> >>>>>> My understanding is that this patch gets applied and your objection will
> >>>>>> be noted.
> >>>>>
> >>>>> My preference is that zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
> >>>>> allocations, which is a low-hanging fruit towards GFP_LOCKLESS mentioned at
> >>>>> https://lkml.kernel.org/r/ZG3+l4qcCWTPtSMD@dhcp22.suse.cz and
> >>>>> https://lkml.kernel.org/r/ZJWWpGZMJIADQvRS@dhcp22.suse.cz .
> >>>>>
> >>>>> Maybe we can defer checking zonelist_update_seq till retry check like below,
> >>>>> for this is really an infrequent event.
> >>>>>
> >>>>
> >>>> An updated version with comments added.
> >>>
> >>> Seriously, don't you see how hairy all this is? And for what? Nitpicking
> >>> something that doesn't seem to be a real problem in the first place?
> >>
> >> Seriously, can't you find "zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
> >> allocations, which is a low-hanging fruit towards GFP_LOCKLESS" !?
> > 
> > I do not think we have concluded that we want to support GFP_LOCKLESS.
> > This might be trivial straightforward now but it imposes some constrains
> > for future maintainability. So far we haven't heard about many usecases
> > where this would be needed and a single one is not sufficient IMHO.
> 
> When you introduced a word GFP_LOCKLESS in the link above, I was wondering the meaning
> of "LESS" part. Since we know that it is difficult to achieve "hold 0 lock during memory
> allocation", "hold least locks during memory allocation" will be at best. Therefore,
> GFP_LOCKLESS is as misleading name as GFP_ATOMIC. GFP_LOCK_LEAST or GFP_LEAST_LOCKS will
> represent the real behavior better.

I am not sure I understand what least locks mean actually. I guess what
you wanted to say is that there are no locks or other synchronization
means with external visibility/dependencies used. In other words a mode
which can be called from any locking context. That would be certainly
possible and whether any internal locks are used or not is an
implementation detail as long as the no external visibility/dependencies 
rule is held. I do not really want to start the naming discussion as it
is not really clear we want/need to provide such a strong guarantee.
-- 
Michal Hocko
SUSE Labs
