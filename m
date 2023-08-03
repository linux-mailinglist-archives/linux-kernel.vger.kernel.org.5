Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9576ED28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjHCOt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjHCOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:49:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520CCA3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:49:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C2CC21900;
        Thu,  3 Aug 2023 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691074195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNsMn66aPrXCwyWEFx/U4iJZBEPN4KAvlDUuVw6PgmA=;
        b=cD3jGFizMcCBYzd8B77P+NaaETqeAT5vbTb6+VnG+9wkzOE8XyREcov67jyuR3ZGzMuKJA
        1vcevKT2NTuV91JMXUty7jRqTGXmK+Nb98Xj9lzsjeGtV80kIwI/M5F2rbxOUfatt895kN
        rLTMdVvsGJSTU1wX/dWwh21LiKZWLlk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D827A1333C;
        Thu,  3 Aug 2023 14:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8ovRMZK+y2QmHAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 03 Aug 2023 14:49:54 +0000
Date:   Thu, 3 Aug 2023 16:49:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <ZMu+kn/g4idBcycV@dhcp22.suse.cz>
References: <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <ZJmkPuqpW-wQAyNz@alley>
 <a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp>
 <20230727151029.e_M9bi8N@linutronix.de>
 <b6ba16ce-4849-d32c-68fe-07a15aaf9d9c@I-love.SAKURA.ne.jp>
 <649fa1a7-4efd-8cc7-92c7-ac7944adc283@I-love.SAKURA.ne.jp>
 <ZMfETPzGfpPP7F79@dhcp22.suse.cz>
 <60d4dc52-9281-9266-4294-b514bd09e6e8@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d4dc52-9281-9266-4294-b514bd09e6e8@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-08-23 22:18:10, Tetsuo Handa wrote:
> On 2023/07/31 23:25, Michal Hocko wrote:
> > On Sat 29-07-23 20:05:43, Tetsuo Handa wrote:
> >> On 2023/07/29 14:31, Tetsuo Handa wrote:
> >>> On 2023/07/28 0:10, Sebastian Andrzej Siewior wrote:
> >>>> On 2023-06-28 21:14:16 [+0900], Tetsuo Handa wrote:
> >>>>>> Anyway, please do not do this change only because of printk().
> >>>>>> IMHO, the current ordering is more logical and the printk() problem
> >>>>>> should be solved another way.
> >>>>>
> >>>>> Then, since [PATCH 1/2] cannot be applied, [PATCH 2/2] is automatically
> >>>>> rejected.
> >>>>
> >>>> My understanding is that this patch gets applied and your objection will
> >>>> be noted.
> >>>
> >>> My preference is that zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
> >>> allocations, which is a low-hanging fruit towards GFP_LOCKLESS mentioned at
> >>> https://lkml.kernel.org/r/ZG3+l4qcCWTPtSMD@dhcp22.suse.cz and
> >>> https://lkml.kernel.org/r/ZJWWpGZMJIADQvRS@dhcp22.suse.cz .
> >>>
> >>> Maybe we can defer checking zonelist_update_seq till retry check like below,
> >>> for this is really an infrequent event.
> >>>
> >>
> >> An updated version with comments added.
> > 
> > Seriously, don't you see how hairy all this is? And for what? Nitpicking
> > something that doesn't seem to be a real problem in the first place?
> 
> Seriously, can't you find "zonelist_update_seq is not checked by !__GFP_DIRECT_RECLAIM
> allocations, which is a low-hanging fruit towards GFP_LOCKLESS" !?

I do not think we have concluded that we want to support GFP_LOCKLESS.
This might be trivial straightforward now but it imposes some constrains
for future maintainability. So far we haven't heard about many usecases
where this would be needed and a single one is not sufficient IMHO.
-- 
Michal Hocko
SUSE Labs
