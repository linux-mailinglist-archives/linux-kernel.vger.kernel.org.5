Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDE87F2276
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjKUAqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjKUAqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:46:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D53A91
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:45:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5D8C433C7;
        Tue, 21 Nov 2023 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700527558;
        bh=7ITtsMr3bGAuekf6mH52bfGLbeQOxBb4WvruWUP+jT8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GEhEQKFi84qpoygDqVA5aG1BtFAA18v55zAnBg31Nn9mQklTdwnwuqoZyUPpkR7UU
         tfIl3zVZKT5Occ1ud0QwQ93dGJC6znGLlhL8GaiVRbSJj01MlUuk5wjbNESkENOYGH
         SYnuFHCerdtboi27/+nn1YUtl2RUt/GH9h9ddkpVKmlGCzZnKkJD3jehwm/F0HQOBh
         o7RGT0QxSdQfiArw8DtRu9vHZY6Lbtk2wx1Z/kbCFPyJG1zCSWegHlHNCCUM82SHS7
         mg9oGTK7L8dlDzr24vwA0AdrBrP9s4gZOaZQo47dje9l2NvS/IkSAJNVjoWAJK2esp
         tM+kleucCPwcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF132CE1390; Mon, 20 Nov 2023 16:45:57 -0800 (PST)
Date:   Mon, 20 Nov 2023 16:45:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [RFC PATCH 57/86] coccinelle: script to remove cond_resched()
Message-ID: <7d85fbde-fc8d-44b4-802e-376a475891e6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:07:53PM -0800, Ankur Arora wrote:
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

This series looks to get rid of stall warnings for long in-kernel
preempt-enabled code paths, which is of course a very good thing.
But removing all of the cond_resched() calls can actually increase
scheduling latency compared to the current CONFIG_PREEMPT_NONE=y state,
correct?

If so, it would be good to take a measured approach.  For example, it
is clear that a loop that does a cond_resched() every (say) ten jiffies
can remove that cond_resched() without penalty, at least in kernels built
with either CONFIG_NO_HZ_FULL=n or CONFIG_PREEMPT=y.  But this is not so
clear for a loop that does a cond_resched() every (say) ten microseconds.

Or am I missing something here?

							Thanx, Paul

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
> +
> +@ r2 @
> +expression E;
> +statement S,T;
> +@@
> +(
> + E;
> +|
> + if (E) S
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
> +|
> + if (E) S else T
> +)
> -- 
> 2.31.1
> 
