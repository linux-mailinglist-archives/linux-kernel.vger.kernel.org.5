Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0173D76D0FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjHBPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjHBPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:06:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91305421A;
        Wed,  2 Aug 2023 08:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 665BF619D3;
        Wed,  2 Aug 2023 15:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4CAC433C8;
        Wed,  2 Aug 2023 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690988708;
        bh=r1VqFu8OfO1u5SoU4EmzmyOkzQIjy5fxk4p2tga+KAM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OwkIN+dIl1O3NsTYTQe/70zZ0rznSUs8gByfm0OBc7zvmQMLiMvn3CLkT+eKbTOUj
         PAil3+ubHsZ183mPtIUzm7PUQB6y0mAJCa+ZRi4IFyAsz+TTY/1TkUdSiXarHW0wAz
         iOQIdIMPD+I6kqL3/keDQMu2JiUg6eDoND0lZQeE8NMIt/M0MS6SiHL4vgzDv8IXWm
         SbiGyEPgRIcHXNwuZR+KJ0+uo/YJIVF0VevuHZ1ptU8COE5mi0ssQMF5ifOCf/ll3L
         X216QF4sppcAbe5WSg6P4NdMjHWOwYBPW6WG3U0mSYjjAHuD4c86lo34qhNQpb9FZp
         ZZ0ci2gx+3C6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5C2E3CE092F; Wed,  2 Aug 2023 08:05:08 -0700 (PDT)
Date:   Wed, 2 Aug 2023 08:05:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Roy Hopkins <rhopkins@suse.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Message-ID: <063a2eba-6b5e-40bc-afd4-7d26f12762e4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
 <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
 <4f18d78411a5477690640a168e0e5d9f28d1c015.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f18d78411a5477690640a168e0e5d9f28d1c015.camel@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 02:57:56PM +0100, Roy Hopkins wrote:
> On Tue, 2023-08-01 at 12:11 -0700, Paul E. McKenney wrote:
> > On Tue, Aug 01, 2023 at 10:32:45AM -0700, Guenter Roeck wrote:
> > 
> > 
> > Please see below for my preferred fix.  Does this work for you guys?
> > 
> > Back to figuring out why recent kernels occasionally to blow up all
> > rcutorture guest OSes...
> > 
> >                                                         Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 7294be62727b..2d5b8385c357 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -570,10 +570,12 @@ static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
> >         if (unlikely(midboot)) {
> >                 needgpcb = 0x2;
> >         } else {
> > +               mutex_unlock(&rtp->tasks_gp_mutex);
> >                 set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
> >                 rcuwait_wait_event(&rtp->cbs_wait,
> >                                    (needgpcb = rcu_tasks_need_gpcb(rtp)),
> >                                    TASK_IDLE);
> > +               mutex_lock(&rtp->tasks_gp_mutex);
> >         }
> >  
> >         if (needgpcb & 0x2) {
> 
> Your preferred fix looks good to me.
> 
> With the original code I can quite easily reproduce the problem on my 
> system every 10 reboots or so. With your fix in place the problem no
> longer occurs.

Very good, thank you!  May I add your Tested-by?

							Thanx, Paul
