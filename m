Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B85F7E4CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbjKGXT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjKGXTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:19:25 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90944129
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cBa0zQZbsO89eYHjjLsYK/1rbltQ1z3rYm0sN7tN0X4=;
  b=R+dEyP+r6EkVbbTZ/eAkNye93CZxpUYadd7k1Juu/Ow1FsjB6JmRclx7
   lCuiFER3mTmM+ClUUYO8s2WA2W2aLAc8yF3bogeURrr+i0tBqDzKSZvM4
   oL7N/fht1HEMcaVISKeq1iutIlKG9mrAzwYf2UQZ+Pj/kTSXPYY3c81SJ
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,284,1694728800"; 
   d="scan'208";a="135141790"
Received: from 71-219-23-58.chvl.qwest.net (HELO hadrien) ([71.219.23.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:19:14 +0100
Date:   Tue, 7 Nov 2023 18:19:13 -0500 (EST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Ankur Arora <ankur.a.arora@oracle.com>
cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [RFC PATCH 57/86] coccinelle: script to remove cond_resched()
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
Message-ID: <f55cbce4-42c6-f49a-482-88ec7b893dea@inria.fr>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com> <20231107230822.371443-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Nov 2023, Ankur Arora wrote:

> Rudimentary script to remove the straight-forward subset of
> cond_resched() and allies:
>
> 1)  if (need_resched())
> 	  cond_resched()
>
> 2)  expression*;
>     cond_resched();  /* or in the reverse order */
>
> 3)  if (expression)
> 	statement
>     cond_resched();  /* or in the reverse order */
>
> The last two patterns depend on the control flow level to ensure
> that the complex cond_resched() patterns (ex. conditioned ones)
> are left alone and we only pick up ones which are only minimally
> related the neighbouring code.
>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  scripts/coccinelle/api/cond_resched.cocci | 53 +++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 scripts/coccinelle/api/cond_resched.cocci
>
> diff --git a/scripts/coccinelle/api/cond_resched.cocci b/scripts/coccinelle/api/cond_resched.cocci
> new file mode 100644
> index 000000000000..bf43768a8f8c
> --- /dev/null
> +++ b/scripts/coccinelle/api/cond_resched.cocci
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Remove naked cond_resched() statements
> +///
> +//# Remove cond_resched() statements when:
> +//#   - executing at the same control flow level as the previous or the
> +//#     next statement (this lets us avoid complicated conditionals in
> +//#     the neighbourhood.)
> +//#   - they are of the form "if (need_resched()) cond_resched()" which
> +//#     is always safe.
> +//#
> +//# Coccinelle generally takes care of comments in the immediate neighbourhood
> +//# but might need to handle other comments alluding to rescheduling.
> +//#
> +virtual patch
> +virtual context
> +
> +@ r1 @
> +identifier r;
> +@@
> +
> +(
> + r = cond_resched();
> +|
> +-if (need_resched())
> +-	cond_resched();
> +)

This rule doesn't make sense.  The first branch of the disjunction will
never match a a place where the second branch matches.  Anyway, in the
second branch there is no assignment, so I don't see what the first branch
is protecting against.

The disjunction is just useless.  Whether it is there or or whether only
the second brancha is there, doesn't have any impact on the result.

> +
> +@ r2 @
> +expression E;
> +statement S,T;
> +@@
> +(
> + E;
> +|
> + if (E) S

This case is not needed.  It will be matched by the next case.

> +|
> + if (E) S else T
> +|
> +)
> +-cond_resched();
> +
> +@ r3 @
> +expression E;
> +statement S,T;
> +@@
> +-cond_resched();
> +(
> + E;
> +|
> + if (E) S

As above.

> +|
> + if (E) S else T
> +)

I have the impression that you are trying to retain some cond_rescheds.
Could you send an example of one that you are trying to keep?  Overall,
the above rules seem a bit ad hoc.  You may be keeping some cases you
don't want to, or removing some cases that you want to keep.

Of course, if you are confident that the job is done with this semantic
patch as it is, then that's fine too.

julia
