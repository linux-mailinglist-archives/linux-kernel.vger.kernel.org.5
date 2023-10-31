Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD37DCE84
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbjJaN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344672AbjJaN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:57:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF2DE;
        Tue, 31 Oct 2023 06:57:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B88C433C7;
        Tue, 31 Oct 2023 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698760648;
        bh=xMTjHScFFr2o8yuO0RmPKlhSKjlfiKYQxGGNU/+pEpQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AYQ2bO43RzIXzw5nz9+nLznLxr9eZ8732uxOGuXAYY6La2DQ8HpYN8gNe37GLxNHe
         jqWVME/XGDIJ3XFx49te6k0v99e4lynsaQJcBUMKazQ+TbUo54dNAUl3giJXH5uUaH
         tIHc0QxmP9Sj9hGUSC77IZoFAbuGVRVduWWdqjYqbTDBVIBxmMH1Gaf9gnusHYW2ue
         rm6hsZTu1t8z6WXEHM1WV53mJqDnDbMV41PmDvzfcVAJZwleC7Uh9514KgDH5j8lP7
         BVlmSIHuFeRsLVlhyD1eHd0ftgpVu7sFjYBIqLLYF8dKWYxLlZyKfF9Imv3Rz76X57
         c9jqQ5y2v5WpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 58C05CE086F; Tue, 31 Oct 2023 06:57:28 -0700 (PDT)
Date:   Tue, 31 Oct 2023 06:57:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
Message-ID: <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZTuf+xNrfqGjHFDK@lothringen>
 <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUDUlQq6hEEPBiCR@lothringen>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:19:01AM +0100, Frederic Weisbecker wrote:
> On Mon, Oct 30, 2023 at 06:12:51PM -1000, Linus Torvalds wrote:
> > On Fri, 27 Oct 2023 at 01:33, Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > rcu/stall: Stall detection updates. Introduce RCU CPU Stall notifiers
> > >         that allows a subsystem to provide informations to help debugging.
> > >         Also cure some false positive stalls.
> > 
> > I absolutely detest this stall notifier thing.
> > 
> > Putting the stall notifier before the stall message does not "help
> > debugging". Quite the reverse. It ends up being a lovely way to make
> > sure that the debug message is never printed, because there's some
> > entirely untested - and thus buggy - notifier on the chain before the
> > printout from the actual stall code.
> > 
> > I've pulled this, but I really want to voice my objection against
> > these kinds of "debugging aids". I have personally spent way too many
> > hours debugging a dead machine because some "debug aid" ended up being
> > untested garbage.
> > 
> > If you absolutely think that this is a worthy and useful thing to do,
> > then at the very least make sure that these "debug aids" will always
> > come *after* the core output, and can't make things horrendously
> > worse.
> > 
> > But in general, think twice before adding "maybe somebody else wants
> > to print debug info". Because unless you have a really really REALLY
> > good reason for it, it's more likely to hurt than to help.
> > 
> > Right now I see no users of this except for the rcu torture code, and
> > it certainly doesn't seem hugely important there. And so I'm wondering
> > what the actual real use-case would be.
> 
> I see, one possibility is to revert this and switch to normal calls
> for any future debug information to add from another subsystem. I'll
> wait for Paul's opinion...

The use case thus far is where the RCU CPU stall warning is due to
locks being spun for or held for excessive periods of times, and then
the called code prints out the relevant debug information.  In this
particular case, the RCU CPU stall warning message is just added noise.
And if we were to print the RCU CPU stall warning first, we would
likely disturb the locking state, thus rendering the corresponding
debug information useless.

But I completely agree that a poorly planned use of this facility would
have all the problems that Linus has seen in the past.

Would it help if we make rcu_stall_chain_notifier_register() print a
suitably obnoxious message saying that future RCU CPU stall warnings
might be unreliable?

							Thanx, Paul
