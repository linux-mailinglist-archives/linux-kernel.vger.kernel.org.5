Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187E3807FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjLGEhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjLGEhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:37:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897710C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:37:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E99C433C7;
        Thu,  7 Dec 2023 04:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701923828;
        bh=J/VsET9W1xTAZ1BYcQcmQfYgWVlazcI6Cc/4X4dTaUE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lO7xMQ/QRFPtQ6IcrCFyd2vs+0r9ouZAW/Bj1uZ9qEVQqcSwhVsDDuvfxAZrZzT5K
         BHROptZV2Qf9yA8bXQmRtKhRio7Pwc8T/qPn7uvp6XEUbwdZtlC1hzpTaDAYgDmt+1
         ClVCrLpxs+ch+SZz+OEs82pbU+oTYaHr5vOnW9RPjVvYnDm0qnM4bSzWb4tsvcmfwI
         aIYxnR54AABMdDdFq9tS3p38BYOfexP/7NLbmd6CApHePM6n5ww+dY6tZ//X11kG1P
         BUTLqW56cxsse460LTYzc+NjVdZymY7S8Xp02IMF7I3GrTq/Fwmn6/0qCCOntoXUHU
         IWJB9WUSy5Ozw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D5F00CE0E88; Wed,  6 Dec 2023 20:37:07 -0800 (PST)
Date:   Wed, 6 Dec 2023 20:37:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
Message-ID: <3cc64b80-0975-4cdf-81ea-952ca80976e4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87v89lzu5a.ffs@tglx>
 <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
 <87zfymn6h9.fsf@oracle.com>
 <20231206211022.710ada02@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206211022.710ada02@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 09:10:22PM -0500, Steven Rostedt wrote:
> On Wed, 06 Dec 2023 17:31:30 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
> > ---
> > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > index 9aa6358a1a16..d8139cda8814 100644
> > --- a/include/linux/preempt.h
> > +++ b/include/linux/preempt.h
> > @@ -226,9 +226,11 @@ do { \
> >  #ifdef CONFIG_PREEMPTION
> >  #define preempt_enable() \
> >  do { \
> >  	barrier(); \
> >  	if (unlikely(preempt_count_dec_and_test())) \
> >  		__preempt_schedule(); \
> > +	else if (unlikely(raw_cpu_read(rcu_data.rcu_urgent_qs))) \
> 
> Shouldn't this still have the:
> 
> 	else if (!IS_ENABLED(CONFIG_PREEMPT_RCU) && \
> 
> That is, is it needed when PREEMPT_RCU is set?

Given that PREEMPT_RCU has been getting along fine without it, I agree
with Steve on this one.  Unless and until someone demonstrates otherwise,
but such a demonstration would almost certainly affect current code,
not just the lazy-preemption changes.

							Thanx, Paul

> -- Steve
> 
> 
> > +		rcu_all_qs_check();
> >  } while (0)
> > 
> >  #define preempt_enable_notrace() \
