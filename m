Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDA8757091
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGQXgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGQXgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:36:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDD71706;
        Mon, 17 Jul 2023 16:35:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DCA661343;
        Mon, 17 Jul 2023 23:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64371C433C8;
        Mon, 17 Jul 2023 23:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689636846;
        bh=17/yjLZ3CC6qr1+a8RPDoq6A25uTlcZUJcXhF1nvdQU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=km0YiWnzR6UnEJIm144zn1VhRozOklrcATG2EUO14RSBZz9B3pF2tRcSB2/HblsYV
         rh6dLQhc1ZQnChiJVTWXBOAGjUdna6jxCjrP53V/Gp9lIv0HAvD+lZ+FuiWGK32UwY
         sY1I7nAxH53qA854sZPVecuqipCVGzCRceZOCDvJfW3ufvJkXxRHXheFNi1B/lSiCf
         ClYVLYMTbB7H9cvAK/IQoJje5IUciwZFwPNCz+uTzwAeVXXfYzStLuO9sXlYwklP7L
         IuvxHManrnYPOclvYIZQstWtzBgkuRHYgxzy5UayRYoez2kCmkMr88/BjTVhSAQrhY
         oVzldZH5rrt+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECDD8CE0367; Mon, 17 Jul 2023 16:34:05 -0700 (PDT)
Date:   Mon, 17 Jul 2023 16:34:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of
 RCU Tasks Trace
Message-ID: <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
 <20230717180454.1097714-5-paulmck@kernel.org>
 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:34:14PM -0700, Joe Perches wrote:
> On Mon, 2023-07-17 at 11:04 -0700, Paul E. McKenney wrote:
> > RCU Tasks Trace is quite specialized, having been created specifically
> > for sleepable BPF programs.  Because it allows general blocking within
> > readers, any new use of RCU Tasks Trace must take current use cases into
> > account.  Therefore, update checkpatch.pl to complain about use of any of
> > the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
> > 
> > Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
> > Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
> > Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
> > Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: <bpf@vger.kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  scripts/checkpatch.pl | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7457,6 +7457,24 @@ sub process {
> >  			}
> >  		}
> >  
> > +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> > +		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
> > +		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
> > +		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
> > +		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
> > +		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
> > +		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
> > +		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
> > +			if ($realfile !~ m@^kernel/bpf@ &&
> > +			    $realfile !~ m@^include/linux/bpf@ &&
> > +			    $realfile !~ m@^net/bpf@ &&
> > +			    $realfile !~ m@^kernel/rcu@ &&
> > +			    $realfile !~ m@^include/linux/rcu@) {
> 
> Functions and paths like these tend to be accreted.
> 
> Please use a variable or 2 like:
> 
> our $rcu_trace_funcs = qr{(?x:
> 	rcu_read_lock_trace |
> 	rcu_read_lock_trace_held |
> 	rcu_read_unlock_trace |
> 	call_rcu_tasks_trace |
> 	synchronize_rcu_tasks_trace |
> 	rcu_barrier_tasks_trace |
> 	rcu_request_urgent_qs_task
> )};
> our $rcu_trace_paths = qr{(?x:
> 	kernel/bfp/ |
> 	include/linux/bpf |
> 	net/bpf/ |
> 	kernel/rcu/ |
> 	include/linux/rcu
> )};

Like this?

# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
		our $rcu_trace_funcs = qr{(?x:
			rcu_read_lock_trace |
			rcu_read_lock_trace_held |
			rcu_read_unlock_trace |
			call_rcu_tasks_trace |
			synchronize_rcu_tasks_trace |
			rcu_barrier_tasks_trace |
			rcu_request_urgent_qs_task
		)};
		our $rcu_trace_paths = qr{(?x:
			kernel/bfp/ |
			include/linux/bpf |
			net/bpf/ |
			kernel/rcu/ |
			include/linux/rcu
		)};
		if ($line =~ /$rcu_trace_funcs/) {
			if ($realfile !~ m@^$rcu_trace_paths@) {
				WARN("RCU_TASKS_TRACE",
				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
			}
		}

No, that is definitely wrong.  It has lost track of the list of pathnames,
thus complaining about uses of those functions in files where their use
is permitted.

But this seems to work:

# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
		our $rcu_trace_funcs = qr{(?x:
			rcu_read_lock_trace |
			rcu_read_lock_trace_held |
			rcu_read_unlock_trace |
			call_rcu_tasks_trace |
			synchronize_rcu_tasks_trace |
			rcu_barrier_tasks_trace |
			rcu_request_urgent_qs_task
		)};
		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
			if ($realfile !~ m@^kernel/bpf@ &&
			    $realfile !~ m@^include/linux/bpf@ &&
			    $realfile !~ m@^net/bpf@ &&
			    $realfile !~ m@^kernel/rcu@ &&
			    $realfile !~ m@^include/linux/rcu@) {
				WARN("RCU_TASKS_TRACE",
				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
			}
		}

Maybe the "^" needs to be distributed into $rcu_trace_paths?

# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
		our $rcu_trace_funcs = qr{(?x:
			rcu_read_lock_trace |
			rcu_read_lock_trace_held |
			rcu_read_unlock_trace |
			call_rcu_tasks_trace |
			synchronize_rcu_tasks_trace |
			rcu_barrier_tasks_trace |
			rcu_request_urgent_qs_task
		)};
		our $rcu_trace_paths = qr{(?x:
			^kernel/bfp/ |
			^include/linux/bpf |
			^net/bpf/ |
			^kernel/rcu/ |
			^include/linux/rcu
		)};
		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
			if ($realfile !~ m@$rcu_trace_paths@) {
				WARN("RCU_TASKS_TRACE",
				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
			}
		}

But no joy here, either.  Which is no surprise, given that perl is
happy to distribute the "\b" and the "\s*\(" across the elements of
$rcu_trace_funcs.  I tried a number of other variations, including
inverting the "if" condition "(!(... =~ ...))", inverting the "if"
condition via an empty "then" clause, replacing the "m@" with "/",
replacing the "|" in the "qr{}" with "&", and a few others.

Again, listing the pathnames explicitly in the second "if" condition
works just fine.

Help?

							Thanx, Paul
