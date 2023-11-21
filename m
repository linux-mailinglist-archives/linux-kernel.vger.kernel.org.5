Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AEC7F2220
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjKUA24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKUA2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:28:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B41B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:28:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2D5C433C7;
        Tue, 21 Nov 2023 00:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700526531;
        bh=tVOIKJd4kJ7fBg79SOhSnFST6k3zeeIVN5WaqodLUIU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aPBqq9i7I2H+gEkoVoqGZAeigotmYTn9NrtyDRrkVpdPb48U7gqp41xPVdezq2b7v
         mefnJIVi7ZTa+tv+ezKbK8qMRK6WubXgofQPZQGEq4cips2WkMjhe0g+wCc1U62BzH
         Q55vlOmcwDarqnGOx7C53FvXxhucy+ZpCa/x2SW4O5wD+52NAzb5Jt5RM6hsjLrjYL
         FShMcdRAb0ciBB18Ssx9ie9Qa0VfagAuGyU+lNrx+22+MTxIZoLMABQHWel/1fKylt
         FqwQasqRaGTL5e5kNJEXRIjiuaX++ZtLp/LgNELIQsOZ+Prewa9EoW9jHgtTOcN4hG
         7ey954nDYv+5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0378BCE1ABD; Mon, 20 Nov 2023 16:28:51 -0800 (PST)
Date:   Mon, 20 Nov 2023 16:28:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Message-ID: <b8c1ae88-5c12-488c-a7af-42119ebd55d2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-48-ankur.a.arora@oracle.com>
 <20231107192703.1c493431@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107192703.1c493431@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:27:03PM -0500, Steven Rostedt wrote:
> On Tue,  7 Nov 2023 13:57:33 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
> > With PREEMPTION being always-on, some configurations might prefer
> > the stronger forward-progress guarantees provided by PREEMPT_RCU=n
> > as compared to PREEMPT_RCU=y.
> > 
> > So, select PREEMPT_RCU=n for PREEMPT_VOLUNTARY and PREEMPT_NONE and
> > enabling PREEMPT_RCU=y for PREEMPT or PREEMPT_RT.
> > 
> > Note that the preemption model can be changed at runtime (modulo
> > configurations with ARCH_NO_PREEMPT), but the RCU configuration
> > is statically compiled.
> 
> I wonder if we should make this a separate patch, and allow PREEMPT_RCU=n
> when PREEMPT=y?

You mean independent of this series?  If so, I am not all that excited
about allowing a new option due to the effect on testing.  With this full
series, the number of test scenarios is preserved.

Actually, that is not exactly true, is it?  It would be if we instead had
something like this:

config PREEMPT_RCU
	bool
	default y if PREEMPT || PREEMPT_RT
	depends on !PREEMPT_NONE && !PREEMPT_VOLUNTARY
	select TREE_RCU

Any reason why this would be a problem?

Or to put it another way, do you know of anyone who really wants
a preemptible kernel (CONFIG_PREEMPT=y, CONFIG_PREEMPT_NONE=n
and CONFIG_PREEMPT_VOLUNTARY=n) but also non-preemptible RCU
(CONFIG_PREEMPT_RCU=y)?  If so, why?  I am having some difficulty seeing
how this combination could be at all helpful.  And if it is not helpful,
we should not allow people to shoot themselves in the foot with it.

> This could allow us to test this without this having to be part of this
> series.

OK, if you mean for testing purposes but not to go to mainline without
the rest of the series, I am good with that idea.

And thank you to Ankur for preserving non-preemptible RCU for those of us
using system that are adequately but not generously endowed with memory!

							Thanx, Paul
