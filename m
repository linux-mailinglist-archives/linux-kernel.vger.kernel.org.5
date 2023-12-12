Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50180F677
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377102AbjLLTTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjLLTTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:19:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ECDB7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:19:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702408788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mkw8JtiCsJ7Vl1QsUbzE+YPMdmlFa+V9d5Dq1ZeMtcg=;
        b=d6nwsqetR2ucbIY6xrRRRbb/rNiQpPWHgVEsptGHLwKfTlq40KfGslD1rRMh27nku9fUjJ
        Iv6MexGumb2wdebAgrmcgByGSsodCWc/vzCmPXxeQfHZzDpWVkHgm6aitKoZITWqSB+gav
        t37GzUnWkQOJlvISwLvAwu2aNsU3mxtjx6bV5UVzs0xtw0NLMov4LTJ+01B4t3tY/bVN/W
        w4C5xLB8au2Sl6baY/w2Ls7k/b8IKY706GJizfjTK/wBEDZX0GiYU69CcYzwBom8jMlrT4
        ZMxjkPF37QxAgHxu/pF2vfPA7Z+F759MOEjAhiUoUCD+bCotSlBacxucqZ8epg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702408788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mkw8JtiCsJ7Vl1QsUbzE+YPMdmlFa+V9d5Dq1ZeMtcg=;
        b=q96ghufpNLOIMSR+mzJKN7xpP9jxSrmd5YuaG4anK3gyn7MN7OKEqZYiqc1UmHalUxmNX4
        Pw0QgWMV3p+LG0Dg==
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     syzbot+f2c4e7bfcca6c6d6324c@syzkaller.appspotmail.com,
        jstultz@google.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] possible deadlock in alarm_handle_timer
In-Reply-To: <CABOYnLzNSp+ESUEtSFYfKbS=RS9XdQM=4uECpqbsdkTiv4scNg@mail.gmail.com>
References: <CABOYnLyHJjv7bZ3CcXo4zAxZ-o49FO9OsWpQrY4tTLNqCbA4Mw@mail.gmail.com>
 <87o7f0qslm.ffs@tglx>
 <CABOYnLzNSp+ESUEtSFYfKbS=RS9XdQM=4uECpqbsdkTiv4scNg@mail.gmail.com>
Date:   Tue, 12 Dec 2023 20:19:47 +0100
Message-ID: <87o7evp6ss.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09 2023 at 11:08, xingwei lee wrote:
> Hello, tglx.

Please do not top-post: https://people.kernel.org/tglx/notes-about-netiquette

> I reprduce this bug with
> linux-next commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?id=eff99d8edbed7918317331ebd1e365d8e955d65e
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=61991b2630c19677
> the same configuration as the syzbot dashboard:
> https://syzkaller.appspot.com/bug?extid=f2c4e7bfcca6c6d6324c.

If you want that people look after your report, then the report needs to
carry the information right away.

> However, I do not entangled the information and just try to generate
> repro.c with the configuration provided by syzbot dashboard.

The reproducer file alone is useless without the rest of the information.

> When I try the repro.c in the lasted upstream commit:
> f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e, it can't crash the kernel at
> all. Should I assume this bug was fixed by the mainline?

Assumptions are not helpful. And if you look at the syzkaller report
then it's entirely clear that the problem is _NOT_ in
alarm_handle_timer().

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sighand->siglock);
                               local_irq_disable();
                               lock(&new_timer->it_lock);
                               lock(&sighand->siglock);
  <Interrupt>
    lock(&new_timer->it_lock);

 *** DEADLOCK ***

So it's clear that sighand->siglock is taken without interrupts disabled
somewhere and the report tells you exactly where:

 -> (&sighand->siglock){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
                      <SNIP/>
                      ptrace_set_stopped kernel/ptrace.c:391 [inline]
                      ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                      <SNIP/>

Now if you'd dig into the git history of linux-next then you'd figure
out that the commit which introduced the problem:

   5431fdd2c181 ("ptrace: Convert ptrace_attach() to use lock guards")

was removed from linux-next on 2023-11-20, which is 3 days later than
the commit tag you linked to and never came back and therefore is not in
mainline.

It's all fine if you try to get a reproducer for something, but you
could have spared all of us a lot of time if you validated that the
problem still persists in linux-next and upstream.

Thanks,

        tglx


