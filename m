Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A67B70A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbjJCSP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbjJCSPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:15:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF76FAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:15:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3F6C433C9;
        Tue,  3 Oct 2023 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696356922;
        bh=2ZuP7lJ7WtElDUZcFZxEyIv7MkbKbZj8sBIbqGclYEY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V+KQtg78vN0drOxU+LcSVPCPrMzHEMbJEGkFhWNnGVZV7bA9m0cRKiw0GhHgeI5SD
         X6mqhyNIQArcKFj6+2hWnOsFvXud97IGnvAS0BUPjVcLN479DgUYQ4UmxOvW53XOJt
         /YvH+gli0Wc7aCp7Ged1MSNst1F3YfDV+epj35vQIAx5gEeoFQKrHKIDL2gwbv2q6f
         GXtIDb/4xvqRoW6A7euoYaN/bpd14Spd0k4m9XOkEi7nvbBIRo+P7JMA6pZ5FBQqOv
         2XRBOL85Y4dyaSGxTyWxexO+fL8MtFtMRTKPlry0BEMnHGTlIpkpo3vxmZ9sTe8p30
         NWdmhbb1+UBTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D5884CE1104; Tue,  3 Oct 2023 11:15:21 -0700 (PDT)
Date:   Tue, 3 Oct 2023 11:15:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org,
        Michael Jeanson <mjeanson@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC PATCH v3 1/5] tracing: Introduce faultable tracepoints (v3)
Message-ID: <2ba5baa2-3598-4499-bd88-b7fc139f6ad8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231002202531.3160-1-mathieu.desnoyers@efficios.com>
 <20231002202531.3160-2-mathieu.desnoyers@efficios.com>
 <20231002191023.6175294d@gandalf.local.home>
 <97c559c9-51cf-415c-8b0b-39eba47b8898@paulmck-laptop>
 <20231002211936.5948253e@gandalf.local.home>
 <5d0771e9-332c-42cd-acf3-53d46bb691f3@paulmck-laptop>
 <20231003100854.7285d2a9@gandalf.local.home>
 <99ec6025-c170-459c-8b43-58cf1a85f832@paulmck-laptop>
 <20231003133856.2879f36f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003133856.2879f36f@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:38:56PM -0400, Steven Rostedt wrote:
> On Tue, 3 Oct 2023 10:33:33 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Tue, Oct 03, 2023 at 10:08:54AM -0400, Steven Rostedt wrote:
> > > On Tue, 3 Oct 2023 06:44:50 -0700
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >   
> > > > > That way it is clear what uses what, as I read the original paragraph a
> > > > > couple of times and could have sworn that rcu_read_lock_trace() required
> > > > > tasks to not block.    
> > > > 
> > > > That would work for me.  Would you like to send a patch, or would you
> > > > rather we made the adjustments?  
> > > 
> > > Which ever.  
> > 
> > OK, how about like this?
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Link: https://lore.kernel.org/all/20231002211936.5948253e@gandalf.local.home/

Thank you both!  Updated as shown below.

						Thanx, Paul

------------------------------------------------------------------------

commit 4d2115e8919760c690e30f48cae2f017c1581546
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Oct 3 10:30:01 2023 -0700

    doc: Clarify RCU Tasks reader/updater checklist
    
    Currently, the reader/updater compatibility rules for the three RCU
    Tasks flavors are squished together in a single paragraph, which can
    result in confusion.  This commit therefore splits them out into a list,
    clearly showing the distinction between these flavors.
    
    Link: https://lore.kernel.org/all/20231002211936.5948253e@gandalf.local.home/
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index bd3c58c44bef..c432899aff22 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -241,15 +241,22 @@ over a rather long period of time, but improvements are always welcome!
 	srcu_struct.  The rules for the expedited RCU grace-period-wait
 	primitives are the same as for their non-expedited counterparts.
 
-	If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
-	then the readers must refrain from executing voluntary
-	context switches, that is, from blocking.  If the updater uses
-	call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
-	the corresponding readers must use rcu_read_lock_trace() and
-	rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
-	or synchronize_rcu_tasks_rude(), then the corresponding readers
-	must use anything that disables preemption, for example,
-	preempt_disable() and preempt_enable().
+	Similarly, it is necssary to correctly use the RCU Tasks flavors:
+
+	a.	If the updater uses synchronize_rcu_tasks() or
+		call_rcu_tasks(), then the readers must refrain from
+		executing voluntary context switches, that is, from
+		blocking.
+
+	b.	If the updater uses call_rcu_tasks_trace()
+		or synchronize_rcu_tasks_trace(), then the
+		corresponding readers must use rcu_read_lock_trace()
+		and rcu_read_unlock_trace().
+
+	c.	If an updater uses call_rcu_tasks_rude() or
+		synchronize_rcu_tasks_rude(), then the corresponding
+		readers must use anything that disables preemption,
+		for example, preempt_disable() and preempt_enable().
 
 	Mixing things up will result in confusion and broken kernels, and
 	has even resulted in an exploitable security issue.  Therefore,
