Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057A077AC40
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHMVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjHMVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 17:30:54 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EC1510D7;
        Sun, 13 Aug 2023 14:30:55 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id E60FF92009C; Sun, 13 Aug 2023 23:30:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id DFDBE92009B;
        Sun, 13 Aug 2023 22:30:52 +0100 (BST)
Date:   Sun, 13 Aug 2023 22:30:52 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] MIPS: Remove noreturn attribute for die()
In-Reply-To: <13aaa917-e55d-f529-8b3f-cab285402808@loongson.cn>
Message-ID: <alpine.DEB.2.21.2308132148500.8596@angie.orcam.me.uk>
References: <1690887599-11442-1-git-send-email-yangtiezhu@loongson.cn> <alpine.DEB.2.21.2308081544180.38537@angie.orcam.me.uk> <13aaa917-e55d-f529-8b3f-cab285402808@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023, Tiezhu Yang wrote:

> >  So you want to keep a task alive that has caused a kernel oops in the
> > process context in this case, right?  What purpose would it be for and
> > what condition causes `notify_die' to return NOTIFY_STOP?  IOW why is
> > there no need to call `make_task_dead' in this case?
> 
> I did some research, hope it is useful.
> 
> There is a related description in Documentation/input/notifier.rst:
> 
>   For each kind of event but the last, the callback may return
>   NOTIFY_STOP in order to "eat" the event: the notify loop is
>   stopped and the keyboard event is dropped.

 I saw that, but this is irrelevant.  Dropping a keyboard event won't make 
the system unstable (though it can make a console user unstable, out of 
irritation).

> In commit 748f2edb5271 ("x86 NMI: better support for debuggers"), it said:
> 
>   If the notify is handled with a NOTIFY_STOP return, the
>   system is given a new lease on life.
> 
> In commit 004429956b48 ("handle recursive calls to bust_spinlocks()"),
> it said:
> 
>   However, at least on i386 die() has been capable of returning
>   (and on other architectures this should really be that way, too)
>   when notify_die() returns NOTIFY_STOP.
> 
> In commit 22f5991c85de ("x86-64: honor notify_die() returning NOTIFY_STOP"),
> it said:
> 
>   This requires making die() return a value, making its callers honor
>   this (and be prepared that it may return)
> 
> In commit 620de2f5dc69 ("[IA64] honor notify_die() returning NOTIFY_STOP"),
> it said:
> 
>   This requires making die() and die_if_kernel() return a value,
>   and their callers to honor this (and be prepared that it returns).

 Thanks, that indeed helps, though indirectly.  I think the most relevant, 
though still terse explanation comes from commit 20c0d2d44029 ("[PATCH] 
i386: pass proper trap numbers to die chain handlers"), which I believe is 
the earliest of similar changes.  The patch was originally submitted here: 
<https://lore.kernel.org/r/43DDF02E.76F0.0078.0@novell.com/> and hardly 
any discussion emerged, but I think the key statement is:

"[...] honor the return value from the handler chain invocation in die() 
as, through a debugger, the fault may have been fixed."

Now it makes sense to me: even if ignoring the event will make the system 
unstable, by allowing access through a debugger it has been compromised 
already anyway.

 So I think your change will be good if you update the change description 
to include the justification quoted above rather than just: "the others do 
it too, so it must be good" (though you can of course mention that your 
change also makes our port consistent with other ones).  I suggest linking 
to the original i386 submission too for future reference.

 Also I note that you combine three independent changes into one, so 
please split it into individual patches as per our requirements.

  Maciej
