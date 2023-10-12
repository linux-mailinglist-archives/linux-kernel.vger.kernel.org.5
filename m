Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE37C6B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbjJLKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbjJLKpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:45:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD01CC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:45:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7EAC433C8;
        Thu, 12 Oct 2023 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697107516;
        bh=BulDcowsMTrV6xgTGD2OQVcPXG/gb9pc52EWLjvRut4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DVlxCurFFLw5dSxuTdxeM5Z0Rl9qxStyqwVlAzxy36QGLtWMokRiysVLOwAS6Azcc
         fc7KfTR33WP/C7U5EUqICrUMm2hNTWuq1HvAkNoMLX3702+HygD0CvtsVb3hitxxyq
         g4Z+47/PUqA3DyQKDKfwQfVy4gp+R4m5hV5xmXAdk3TQeC6/yxAGkXsA5eeCPmbrt6
         +/vcdlfB92S927u00ZydSZMtnMB3C3mMc3dlxPjt9jZGpZub8Rof9czjfbkXze5p7R
         +v8Cc5wIZaERz7WNp4Laq+FrXtov7ioCxJZRYuh33hxyG9in6x/5rUF7TqWyNy3cFh
         XnoYb8MEI6XKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CEEDCCE0868; Thu, 12 Oct 2023 03:45:15 -0700 (PDT)
Date:   Thu, 12 Oct 2023 03:45:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, clm@fb.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC x86/nmi] Fix out-of-order nesting checks
Message-ID: <f600d458-49dd-4c83-a40e-982b66c42684@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0cbff831-6e3d-431c-9830-ee65ee7787ff@paulmck-laptop>
 <ZSeUJbZLbk2g7GC/@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSeUJbZLbk2g7GC/@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:37:25AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > The ->idt_seq and ->recv_jiffies variables added by commit 1a3ea611fc10
> > ("x86/nmi: Accumulate NMI-progress evidence in exc_nmi()") place
> > the exit-time check of the bottom bit of ->idt_seq after the
> > this_cpu_dec_return() that re-enables NMI nesting.  This can result in
> > the following sequence of events on a given CPU in kernels built with
> > CONFIG_NMI_CHECK_CPU=y:
> > 
> > o       An NMI arrives, and ->idt_seq is incremented to an odd number.
> >         In addition, nmi_state is set to NMI_EXECUTING==1.
> > 
> > o       The NMI is processed.
> > 
> > o       The this_cpu_dec_return(nmi_state) zeroes nmi_state and returns
> >         NMI_EXECUTING==1, thus opting out of the "goto nmi_restart".
> > 
> > o       Another NMI arrives and ->idt_seq is incremented to an even
> >         number, triggering the warning.  But all is just fine, at least
> >         assuming we don't get so many closely spaced NMIs that the stack
> >         overflows or some such.
> > 
> > Experience on the fleet indicates that the MTBF of this false positive
> > is about 70 years.  Or, for those who are not quite that patient, the
> > MTBF appears to be about one per week per 4,000 systems.
> > 
> > Fix this false-positive warning by moving the "nmi_restart" label before
> > the initial ->idt_seq increment/check and moving the this_cpu_dec_return()
> > to follow the final ->idt_seq increment/check.  This way, all nested NMIs
> > that get past the NMI_NOT_RUNNING check get a clean ->idt_seq slate.
> > And if they don't get past that check, they will set nmi_state to
> > NMI_LATCHED, which will cause the this_cpu_dec_return(nmi_state)
> > to restart.
> 
> This looks like a sensible fix: the warning should obviously be atomic wrt. 
> the no-nesting region. I've applied your fix to tip:x86/irq, as it doesn't 
> seem urgent enough with a MTBF of 70 years to warrant tip:x86/urgent handling. ;-)

Works for me!  ;-)

And thank you!

							Thanx, Paul
