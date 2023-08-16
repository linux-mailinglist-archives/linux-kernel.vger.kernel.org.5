Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678BF77E09F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbjHPLkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244749AbjHPLkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8027138
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692185992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6HuhCJSpj7zKUgGVXW9YbI9WNQUXRLZ8/AthqtZm/c=;
        b=MwoQkARAHxtAT3dxQNBLpl2NpyrV4KCaqYLLdxw4dOvJegy5N2gmMQGT7L4BzSc2tXwAda
        I5DYL0J0hqIux/6XVkFkJ9oDDqHN1xmQLjd21W3Za8DkJtj2WcHTO6jCI5lfopqR0PzCSP
        cRBT2TmIDU2rXkcXks5JEg+aj2ypbeM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688-Vf8eWT45N7uD868jFa7V0A-1; Wed, 16 Aug 2023 07:39:49 -0400
X-MC-Unique: Vf8eWT45N7uD868jFa7V0A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC1351C068E1;
        Wed, 16 Aug 2023 11:39:48 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1091492C14;
        Wed, 16 Aug 2023 11:39:47 +0000 (UTC)
Date:   Wed, 16 Aug 2023 07:39:45 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bsegall@google.com,
        boqun.feng@gmail.com, swood@redhat.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, jstultz@google.com,
        juri.lelli@redhat.com, mgorman@suse.de, rostedt@goodmis.org,
        vschneid@redhat.com, vincent.guittot@linaro.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 3/6] sched: Extract __schedule_loop()
Message-ID: <20230816113945.GA639355@lorien.usersys.redhat.com>
References: <20230815110121.117752409@infradead.org>
 <20230815111430.288063671@infradead.org>
 <20230815223301.GC602899@lorien.usersys.redhat.com>
 <20230816100154.k6cmHUUp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816100154.k6cmHUUp@linutronix.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 12:01:54PM +0200 Sebastian Andrzej Siewior wrote:
> On 2023-08-15 18:33:01 [-0400], Phil Auld wrote:
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
> 
> I don't see __schedule_loop in my RT and !RT build. I tried gcc and
> clang.
>

I do.  Admittedly I'm not an expert in how the wchan unwinding works but
we have a slightly older version of this patch in our kernel (schedule_loop
not __schedule_loop). When I added __sched it fixed it.   Maybe there
is something else but that seemed pretty obvious. 


/* Attach to any functions which should be ignored in wchan output. */
#define __sched		__section(".sched.text")

I can't explain why you are not seeing it.


Cheers,
Phil


> Sebastian
> 

-- 

