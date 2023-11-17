Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0927EEF7C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjKQJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbjKQJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:57:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265C52D5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FSq1h7YsVXlzfV2ZBu63aCsUtFkWLsV/De94IDZBeC8=; b=ebplpGNi/HUTr31F88GmPsrxO4
        i/vPMpNtdWd7wGq7xoqg26h3eakMomvGBhIiD8RrFLkqDMbs+WCT/G38oYjq3P8yHm+frdh6F19wP
        XB8RYKooeayiSCa0w46LSBd5xdhw/fFHwvuhqTy4Kr2vAnEYWfFwHKPacAdqbcsL6IuyaO3o015en
        OTIjaFB5q0egOffWDhxBlAbOfcz8uUDXk6B9M8yEh/FOz2t3SUeODlmUH5Q3tlHuulbbNoc89Uy3A
        5xrL2+EKOJrdhopfG0oyJomsl2IMsEQt/6kgVgK1mnPV7BUpAUHWR9BOUoThgshpXKZn0nV0S5vSx
        XzsjF4DA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3vPo-008fIf-2q; Fri, 17 Nov 2023 09:45:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA7E8300478; Fri, 17 Nov 2023 10:45:31 +0100 (CET)
Date:   Fri, 17 Nov 2023 10:45:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com>,
        boqun.feng@gmail.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wander@redhat.com, will@kernel.org
Subject: Re: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
Message-ID: <20231117094531.GN8262@noisy.programming.kicks-ass.net>
References: <000000000000a25ea7060a430d3c@google.com>
 <00000000000064b787060a55354e@google.com>
 <20231117092730.GK8262@noisy.programming.kicks-ass.net>
 <20231117093829.GA32151@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117093829.GA32151@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 10:38:30AM +0100, Oleg Nesterov wrote:
> On 11/17, Peter Zijlstra wrote:
> >
> > On Fri, Nov 17, 2023 at 12:49:04AM -0800, syzbot wrote:
> > > syzbot has bisected this issue to:
> > >
> > > commit 2d25a889601d2fbc87ec79b30ea315820f874b78
> > > Author: Peter Zijlstra <peterz@infradead.org>
> > > Date:   Sun Sep 17 11:24:21 2023 +0000
> > >
> > >     ptrace: Convert ptrace_attach() to use lock guards
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132b7d84e80000
> > > start commit:   f31817cbcf48 Add linux-next specific files for 20231116
> > > git tree:       linux-next
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ab7d84e80000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=172b7d84e80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=cbb25bb9b4d29a773985
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1014d797680000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b1ec67680000
> > >
> > > Reported-by: syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com
> > > Fixes: 2d25a889601d ("ptrace: Convert ptrace_attach() to use lock guards")
> >
> > Hurmph, let me pull that patch from tip and go have a look. Thanks!
> 
> I guess
> 
> 	scoped_guard (write_lock, &tasklist_lock)
> 
> is not right... this needs write_lock_irq().
> 
> I didn't notice this when I reviewed this patch.

Yep, that seems to be the case.

I keep forgetting how to tell the syscall robot to test the below delta,
but I'll push the ammended commit to my staging tree and we'll see what
happens.

---
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -461,7 +461,7 @@ static int ptrace_attach(struct task_str
 				return retval;
 		}
 
-		scoped_guard (write_lock, &tasklist_lock) {
+		scoped_guard (write_lock_irq, &tasklist_lock) {
 			if (unlikely(task->exit_state))
 				return -EPERM;
 			if (task->ptrace)
