Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5837E52D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjKHJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:50:07 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9641B3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HhxaM+9ct1KAcw8VIeJ+z4oy49b3afWo4vOTwZzrlic=;
  b=g7Roo5ZyuocALj/3t3rO+3JAJsUh4HFvENaoQ+tK7ClXtLZlJAVtWNcC
   8o8mQ/F9d8MrSwwp0nvHkjz/6lSP9qBeYJ3TVHiI83qKG9zJdReepaaiW
   jpeaqHjn9CGTVoL2kd0ADtxykV2AUwzzNU+JYr4VEy7/2z9tbw4JoGYd1
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,285,1694728800"; 
   d="scan'208";a="135214412"
Received: from 71-219-23-58.chvl.qwest.net (HELO hadrien) ([71.219.23.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 10:49:54 +0100
Date:   Wed, 8 Nov 2023 04:49:52 -0500 (EST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Ankur Arora <ankur.a.arora@oracle.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [RFC PATCH 57/86] coccinelle: script to remove cond_resched()
In-Reply-To: <875y2cr6ll.fsf@oracle.com>
Message-ID: <43db286-7c8f-5c4-3f11-b8c103092c@inria.fr>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com> <20231107230822.371443-1-ankur.a.arora@oracle.com> <f55cbce4-42c6-f49a-482-88ec7b893dea@inria.fr> <875y2cr6ll.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2023, Ankur Arora wrote:

>
> Julia Lawall <julia.lawall@inria.fr> writes:
>
> > On Tue, 7 Nov 2023, Ankur Arora wrote:
> >
> >> Rudimentary script to remove the straight-forward subset of
> >> cond_resched() and allies:
> >>
> >> 1)  if (need_resched())
> >> 	  cond_resched()
> >>
> >> 2)  expression*;
> >>     cond_resched();  /* or in the reverse order */
> >>
> >> 3)  if (expression)
> >> 	statement
> >>     cond_resched();  /* or in the reverse order */
> >>
> >> The last two patterns depend on the control flow level to ensure
> >> that the complex cond_resched() patterns (ex. conditioned ones)
> >> are left alone and we only pick up ones which are only minimally
> >> related the neighbouring code.
> >>
> >> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> >> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> >> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> ---
> >>  scripts/coccinelle/api/cond_resched.cocci | 53 +++++++++++++++++++++++
> >>  1 file changed, 53 insertions(+)
> >>  create mode 100644 scripts/coccinelle/api/cond_resched.cocci
> >>
> >> diff --git a/scripts/coccinelle/api/cond_resched.cocci b/scripts/coccinelle/api/cond_resched.cocci
> >> new file mode 100644
> >> index 000000000000..bf43768a8f8c
> >> --- /dev/null
> >> +++ b/scripts/coccinelle/api/cond_resched.cocci
> >> @@ -0,0 +1,53 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/// Remove naked cond_resched() statements
> >> +///
> >> +//# Remove cond_resched() statements when:
> >> +//#   - executing at the same control flow level as the previous or the
> >> +//#     next statement (this lets us avoid complicated conditionals in
> >> +//#     the neighbourhood.)
> >> +//#   - they are of the form "if (need_resched()) cond_resched()" which
> >> +//#     is always safe.
> >> +//#
> >> +//# Coccinelle generally takes care of comments in the immediate neighbourhood
> >> +//# but might need to handle other comments alluding to rescheduling.
> >> +//#
> >> +virtual patch
> >> +virtual context
> >> +
> >> +@ r1 @
> >> +identifier r;
> >> +@@
> >> +
> >> +(
> >> + r = cond_resched();
> >> +|
> >> +-if (need_resched())
> >> +-	cond_resched();
> >> +)
> >
> > This rule doesn't make sense.  The first branch of the disjunction will
> > never match a a place where the second branch matches.  Anyway, in the
> > second branch there is no assignment, so I don't see what the first branch
> > is protecting against.
> >
> > The disjunction is just useless.  Whether it is there or or whether only
> > the second brancha is there, doesn't have any impact on the result.
> >
> >> +
> >> +@ r2 @
> >> +expression E;
> >> +statement S,T;
> >> +@@
> >> +(
> >> + E;
> >> +|
> >> + if (E) S
> >
> > This case is not needed.  It will be matched by the next case.
> >
> >> +|
> >> + if (E) S else T
> >> +|
> >> +)
> >> +-cond_resched();
> >> +
> >> +@ r3 @
> >> +expression E;
> >> +statement S,T;
> >> +@@
> >> +-cond_resched();
> >> +(
> >> + E;
> >> +|
> >> + if (E) S
> >
> > As above.
> >
> >> +|
> >> + if (E) S else T
> >> +)
> >
> > I have the impression that you are trying to retain some cond_rescheds.
> > Could you send an example of one that you are trying to keep?  Overall,
> > the above rules seem a bit ad hoc.  You may be keeping some cases you
> > don't want to, or removing some cases that you want to keep.
>
> Right. I was trying to ensure that the script only handled the cases
> that didn't have any "interesting" connections to the surrounding code.
>
> Just to give you an example of the kind of constructs that I wanted
> to avoid:
>
> mm/memoy.c::zap_pmd_range():
>
>                 if (addr != next)
>                         pmd--;
>         } while (pmd++, cond_resched(), addr != end);
>
> mm/backing-dev.c::cleanup_offline_cgwbs_workfn()
>
>                 while (cleanup_offline_cgwb(wb))
>                         cond_resched();
>
>
>                 while (cleanup_offline_cgwb(wb))
>                         cond_resched();
>
> But from a quick check the simplest coccinelle script does a much
> better job than my overly complex (and incorrect) one:
>
> @r1@
> @@
> -       cond_resched();
>
> It avoids the first one. And transforms the second to:
>
>                 while (cleanup_offline_cgwb(wb))
>                         {}
>
> which is exactly what I wanted.

Perfect!

It could be good to run both scripts and compare the results.

julia

>
> > Of course, if you are confident that the job is done with this semantic
> > patch as it is, then that's fine too.
>
> Not at all. Thanks for pointing out the mistakes.
>
>
>
> --
> ankur
>
