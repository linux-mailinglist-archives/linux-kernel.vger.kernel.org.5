Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3671D77E35C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbjHPOPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343531AbjHPOPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA62705
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692195264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6qVX4JL8hzYB+i+zAVqFPzRtDjXizOIDWnRU30YDjI=;
        b=efvOUz6ZxR1EZpdLko4lWhAsKA3IftojQ8nImVpKMxwXSyvkJxYj3ZzHgwfmERdKnG0kR4
        f/5GQQ+MvBh3A59ieizZ5uKlzc5axbu7DPTo0LqUCiq2q+P7QTIJ6NLezC+qs8RvMPrUnw
        NyzHBWtKhd4CN1WwtcHhNzrrjLHILuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-wJRE6CGlN6GBpR_FC4Vi_A-1; Wed, 16 Aug 2023 10:14:21 -0400
X-MC-Unique: wJRE6CGlN6GBpR_FC4Vi_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B493800C78;
        Wed, 16 Aug 2023 14:14:20 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF15763F75;
        Wed, 16 Aug 2023 14:14:14 +0000 (UTC)
Date:   Wed, 16 Aug 2023 10:14:10 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bigeasy@linutronix.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bsegall@google.com,
        boqun.feng@gmail.com, swood@redhat.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, jstultz@google.com,
        juri.lelli@redhat.com, mgorman@suse.de, rostedt@goodmis.org,
        vschneid@redhat.com, vincent.guittot@linaro.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 3/6] sched: Extract __schedule_loop()
Message-ID: <20230816141410.GC641857@lorien.usersys.redhat.com>
References: <20230815110121.117752409@infradead.org>
 <20230815111430.288063671@infradead.org>
 <20230815223301.GC602899@lorien.usersys.redhat.com>
 <20230815223926.GC971582@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815223926.GC971582@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:39:26AM +0200 Peter Zijlstra wrote:
> On Tue, Aug 15, 2023 at 06:33:01PM -0400, Phil Auld wrote:
> > Hi Peter,
> > 
> > On Tue, Aug 15, 2023 at 01:01:24PM +0200 Peter Zijlstra wrote:
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > There are currently two implementations of this basic __schedule()
> > > loop, and there is soon to be a third.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Link: https://lkml.kernel.org/r/20230427111937.2745231-2-bigeasy@linutronix.de
> > > ---
> > >  kernel/sched/core.c |   21 +++++++++++----------
> > >  1 file changed, 11 insertions(+), 10 deletions(-)
> > > 
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -6787,16 +6787,21 @@ static void sched_update_worker(struct t
> > >  	}
> > >  }
> > >  
> > > -asmlinkage __visible void __sched schedule(void)
> > > +static __always_inline void __schedule_loop(unsigned int sched_mode)
> > 
> > I think this needs __sched or it's the only thing that ever shows up
> > in wchan. E.g.
> > 
> >   16995 0 bash     S __schedule_loop.constprop.0
> >   17036 1 kworker/ I __schedule_loop.constprop.0
> >   17151 1 kworker/ I __schedule_loop.constprop.0
> >   17235 0 sleep    S __schedule_loop.constprop.0
> >   17236 4 ps       R -
> 
> But but but __always_inline... ?!?
> 

Yep, sorry. Totally missed those characters (and this reply of yours).

The older version from the rt tree had neither. 


Cheers,
Phil
-- 

