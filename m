Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8F7E5C05
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjKHRLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjKHRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:11:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D10D4F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:11:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBD6C433C7;
        Wed,  8 Nov 2023 17:11:35 +0000 (UTC)
Date:   Wed, 8 Nov 2023 12:11:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        David Ahern <dsahern@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Martin Schiller <ms@dev.tdt.de>
Subject: Re: [RFC PATCH 79/86] treewide: net: remove cond_resched()
Message-ID: <20231108121138.114f0f15@gandalf.local.home>
In-Reply-To: <CANn89i+b3=N1gT7rrrxU+zOMN_VzzHjyYW=TeE5AMSoKcdLvyg@mail.gmail.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-23-ankur.a.arora@oracle.com>
        <CANn89i+b3=N1gT7rrrxU+zOMN_VzzHjyYW=TeE5AMSoKcdLvyg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 13:16:17 +0100
Eric Dumazet <edumazet@google.com> wrote:

> > Most of the uses here are in set-1 (some right after we give up a
> > lock or enable bottom-halves, causing an explicit preemption check.)
> >
> > We can remove all of them.  
> 
> A patch series of 86 is not reasonable.

Agreed. The removal of cond_resched() wasn't needed for the RFC, as there's
really no comments needed once we make cond_resched obsolete.

I think Ankur just wanted to send all the work for the RFC to let people
know what he has done. I chalk that up as a Noobie mistake.

Ankur, next time you may want to break things up to get RFCs for each step
before going to the next one.

Currently, it looks like the first thing to do is to start with Thomas's
patch, and get the kinks out of NEED_RESCHED_LAZY, as Thomas suggested.

Perhaps work on separating PREEMPT_RCU from PREEMPT.

Then you may need to work on handling the #ifndef PREEMPTION parts of the
kernel.

And so on. Each being a separate patch series that will affect the way the
rest of the changes will be done.

I want this change too, so I'm willing to help you out on this. If you
didn't start it, I would have ;-)

-- Steve
