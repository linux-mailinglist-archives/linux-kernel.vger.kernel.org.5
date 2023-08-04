Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B2C77070B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjHDR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHDR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:27:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E7212D;
        Fri,  4 Aug 2023 10:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC513620D1;
        Fri,  4 Aug 2023 17:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACA1C433C7;
        Fri,  4 Aug 2023 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691170062;
        bh=AYANuhJfkDjAfC3MryJ2A7DPDDjZNIDvTaz4RAUTOpY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rkC7cPXnep9FLlFMDySqsRPneYVihwtFwRZSsd8LYlIjnvLDzJahYx8fWNJXmdja4
         i49pJRPuRXKCmeg5HOsbyFVcS3MdhDS5WTCZkIcMPfKi6H0cDAHka0t53ePVVhy3w2
         AOwrYpMdjbmjth+HAXZmPFRd4esoxrR9NNhNXiEW83mI7MSrq3hk2Zd+cPVMVTZUwT
         yPxvhrR4shdcQQhB+aJME9qUABrjnN6eA5gMd1WTcIRAz7SD4x0ioQ+V3OrA2NiQUt
         BbyoWJRGje+fYQMKk9gUFVN5qXW5e+cIGmkuCueT0JYjK7KbQP4mF4WrpfXt0t9p9A
         HImuRgYMh6qSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C4316CE0591; Fri,  4 Aug 2023 10:27:41 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:27:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to
 requirements
Message-ID: <c74dd105-cec6-468e-b97e-b22434fa0176@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
 <148CE02E-BBEC-4D30-9C75-6632A110FFC0@joelfernandes.org>
 <E96297CF-6C81-4BB5-BA5A-6734F6B629F4@gmail.com>
 <CAEXW_YRXA3j3k9VRuZJ7d=yo6__TRpeE6igrQ+GEZiyKtFmUOQ@mail.gmail.com>
 <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
 <f5652b1a-de71-4881-8825-fedd73544f54@paulmck-laptop>
 <DFBE4F45-BF8B-4267-93C7-B085A88BE356@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DFBE4F45-BF8B-4267-93C7-B085A88BE356@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 12:33:03AM +0800, Alan Huang wrote:
> 
> >> Yes, a write-write data race where the value is the same is also fine.
> >> 
> >> But they are still data race, if the compiler is within its right to do anything it likes (due to data race),
> >> we still need WRITE_ONCE() in these cases, though it’s semantically safe.
> >> 
> >> IIUC, even with _ONCE(), the compiler is within its right do anything according to the standard (at least before the upcoming C23), because the standard doesn’t consider a volatile access to be atomic.
> > 
> > Volatile accesses are not specified very well in the standard.  However,
> > as a practical matter, compilers that wish to be able to device drivers
> > (whether in kernels or userspace applications) must compile those volatile
> > accesses in such a way to allow reliable device drivers to be written.
> > 
> >> However, the kernel consider the volatile access to be atomic, right?
> > 
> > The compiler must therefore act as if a volatile access to an aligned
> > machine-word size location is atomic.  To see this, consider accesses
> > to memory that is shared by a device driver and that device's firmware,
> > both of which are written in either C or C++.
> 
> I learned these things a few months ago. But still thank you!
> 
> The real problem is that there may be a data race at line 5, so Joel is correct that the compiler
> can cache the value loaded from line 5 according to the standard given that the standard says that
> a data race result in undefined behavior, so the compiler might be allowed to do anything. But from the
> perspective of the kernel, line 5 is likely a diagnostic read, so it’s fine without READ_ONCE() and the
> compiler is not allowed to cache the value.
> 
> This situation is like the volatile access.
> 
> Am I missing something?

I think you have it right.

The point is that we are sometimes more concerned about focusing KCSAN
diagnostics on the core concurrent algorithm, and are willing to take
the very low risk of messed-up diagnostic output in order to get simpler
and better KCSAN diagnostics on the main algorithm.

So in that case, we use data_race() on the diagnostics and other markings
in the main algorithm.

For example, suppose that we had a core algorithm that relied on strict
locking.  In that case, we want to use unmarked plain C-language accesses
in the core algorithm, which will allow KCSAN to flag and accesses that
are not protected by the lock.  But it might be bad for the diagnostic
code to acquire that lock, as this would suppress diagnostics in the case
where the lock was held for too long a time period.  Using data_race()
in the diagnostic code addresses this situation.

							Thanx, Paul


> > Does that help?
> > 
> > Thanx, Paul
> > 
> >> BTW, line 5 in the example is likely to be optimized away. And yes, the compiler can cache the value loaded from line 5 from the perspective of undefined behavior, even if I believe it would be a compiler bug from the perspective of kernel.
> >> 
> >>> result will not change the semantics of the program. But otherwise,
> >>> that's bad.
> >>> 
> >>> [1] https://lwn.net/Articles/793253/#Store%20Tearing
> >>> 
> >>> thanks,
> >>> 
> >>> - Joel
> >>> 
> >>> 
> >>>> 
> >>>>> 
> >>>>> Thanks.
> >>>>> 
> >>>>> 
> >>>>> 
> >>>>>> 
> >>>>>>> +plain accesses of a memory location with rcu_dereference() of the same memory
> >>>>>>> +location, in code involved in a data race.
> >>>>>>> +
> >>>>>>> In short, updaters use rcu_assign_pointer() and readers use
> >>>>>>> rcu_dereference(), and these two RCU API elements work together to
> >>>>>>> ensure that readers have a consistent view of newly added data elements.
> >>>>>>> --
> >>>>>>> 2.41.0.585.gd2178a4bd4-goog
> 
> 
