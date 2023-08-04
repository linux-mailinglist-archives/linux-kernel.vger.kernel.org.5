Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0276F65D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjHDAB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjHDAB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:01:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBA13A9C;
        Thu,  3 Aug 2023 17:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7636B61EE2;
        Fri,  4 Aug 2023 00:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E72C433C8;
        Fri,  4 Aug 2023 00:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691107283;
        bh=cHmGqKaVH+JbvJeqZpbkMs70GSXfEJuWpiEzl0HQHYM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bYC0x5zWPaRuUsIMmGjgGrkPWBzSpzv0+95f0+oAp736qSNn+HhpkdS0FJ2qUZPFs
         uFRW0ipfbkpEmt0z1D/2YJgeADdOsIKPjfTGNi4AOHMz2QNXspMjmYk7xATYJO+MmQ
         Qm/qZ5LsDUEyf5q5H16tneaY+geBaQc0Yw3LhNtWk3ltVT8aAVEs3BOqUdWBzs5LWh
         4lZ048sZRNLITtHyBlaZVSBbvFezz1ML6m1qfAN7tBEaT9T3SUTbBurFDO1snyTcN+
         zMGlGGhD4sDJTXxg2RAYJECJ0yi+L2++411yoPqjlNUAuyJCLb7j5AWknFs17d7FLa
         9MMHp1CUpnaog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5EF78CE092F; Thu,  3 Aug 2023 17:01:23 -0700 (PDT)
Date:   Thu, 3 Aug 2023 17:01:23 -0700
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
Message-ID: <f5652b1a-de71-4881-8825-fedd73544f54@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <A272EB21-28F9-4FFE-A3BB-6689807CC3ED@gmail.com>
 <148CE02E-BBEC-4D30-9C75-6632A110FFC0@joelfernandes.org>
 <E96297CF-6C81-4BB5-BA5A-6734F6B629F4@gmail.com>
 <CAEXW_YRXA3j3k9VRuZJ7d=yo6__TRpeE6igrQ+GEZiyKtFmUOQ@mail.gmail.com>
 <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D3D65E05-AC98-43EA-8B66-CA63E94C1C80@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:25:57AM +0800, Alan Huang wrote:
> > 2023年8月4日 00:01，Joel Fernandes <joel@joelfernandes.org> 写道：
> > On Thu, Aug 3, 2023 at 9:36 AM Alan Huang <mmpgouride@gmail.com> wrote:
> >>> 2023年8月3日 下午8:35，Joel Fernandes <joel@joelfernandes.org> 写道：
> >>>> On Aug 3, 2023, at 8:09 AM, Alan Huang <mmpgouride@gmail.com> wrote:
> >>>>> 2023年8月3日 11:24，Joel Fernandes (Google) <joel@joelfernandes.org> 写道：
> >>>>> Add a detailed note to explain the potential side effects of
> >>>>> plain-accessing the gp pointer using a plain load, without using the
> >>>>> rcu_dereference() macros; which might trip neighboring code that does
> >>>>> use rcu_dereference().
> >>>>> 
> >>>>> I haven't verified this with a compiler, but this is what I gather from
> >>>>> the below link using Will's experience with READ_ONCE().
> >>>>> 
> >>>>> Link: https://lore.kernel.org/all/20230728124412.GA21303@willie-the-truck/
> >>>>> Cc: Will Deacon <will@kernel.org>
> >>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>>> ---
> >>>>> .../RCU/Design/Requirements/Requirements.rst  | 32 +++++++++++++++++++
> >>>>> 1 file changed, 32 insertions(+)
> >>>>> 
> >>>>> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> >>>>> index f3b605285a87..e0b896d3fb9b 100644
> >>>>> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> >>>>> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> >>>>> @@ -376,6 +376,38 @@ mechanism, most commonly locking or reference counting
> >>>>> .. |high-quality implementation of C11 memory_order_consume [PDF]| replace:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
> >>>>> .. _high-quality implementation of C11 memory_order_consume [PDF]: http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
> >>>>> 
> >>>>> +Note that, there can be strange side effects (due to compiler optimizations) if
> >>>>> +``gp`` is ever accessed using a plain load (i.e. without ``READ_ONCE()`` or
> >>>>> +``rcu_dereference()``) potentially hurting any succeeding
> >>>>> +``rcu_dereference()``. For example, consider the code:
> >>>>> +
> >>>>> +   ::
> >>>>> +
> >>>>> +       1 bool do_something_gp(void)
> >>>>> +       2 {
> >>>>> +       3   void *tmp;
> >>>>> +       4   rcu_read_lock();
> >>>>> +       5   tmp = gp; // Plain-load of GP.
> >>>>> +       6   printk("Point gp = %p\n", tmp);
> >>>>> +       7
> >>>>> +       8   p = rcu_dereference(gp);
> >>>>> +       9   if (p) {
> >>>>> +      10     do_something(p->a, p->b);
> >>>>> +      11     rcu_read_unlock();
> >>>>> +      12     return true;
> >>>>> +      13   }
> >>>>> +      14   rcu_read_unlock();
> >>>>> +      15   return false;
> >>>>> +      16 }
> >>>>> +
> >>>>> +The behavior of plain accesses involved in a data race is non-deterministic in
> >>>>> +the face of compiler optimizations. Since accesses to the ``gp`` pointer is
> >>>>> +by-design a data race, the compiler could trip this code by caching the value
> >>>>> +of ``gp`` into a register in line 5, and then using the value of the register
> >>>>> +to satisfy the load in line 10. Thus it is important to never mix
> >>>> 
> >>>> Will’s example is:
> >>>> 
> >>>>   // Assume *ptr is initially 0 and somebody else writes it to 1
> >>>>   // concurrently
> >>>> 
> >>>>   foo = *ptr;
> >>>>   bar = READ_ONCE(*ptr);
> >>>>   baz = *ptr;
> >>>> 
> >>>> Then the compiler is within its right to reorder it to:
> >>>> 
> >>>>  foo = *ptr;
> >>>>  baz = *ptr;
> >>>>  bar = READ_ONCE(*ptr);
> >>>> 
> >>>> So, the result foo == baz == 0 but bar == 1 is perfectly legal.
> >>> 
> >>> Yes, a bad outcome is perfectly legal amidst data race. Who said it is not legal?
> >> 
> >> My understanding is that it is legal even without data race, and the compiler only keeps the order of volatile access.
> > 
> > Yes, but I can bet on it the author of the code would not have
> > intended such an outcome, if they did then Will wouldn't have been
> > debugging it ;-). That's why I called it a bad outcome. The goal of
> > this patch is to document such a possible unintentional outcome.
> > 
> >>>> But the example here is different,
> >>> 
> >>> That is intentional. Wills discussion partially triggered this. Though I am wondering
> >>> if we should document that as well.
> >>> 
> >>>> the compiler can not use the value loaded from line 5
> >>>> unless the compiler can deduce that the tmp is equals to p in which case the address dependency
> >>>> doesn’t exist anymore.
> >>>> 
> >>>> What am I missing here?
> >>> 
> >>> Maybe you are trying to rationalize too much that the sequence mentioned cannot result
> >>> in a counter intuitive outcome like I did?
> >>> 
> >>> The point AFAIU is not just about line 10 but that the compiler can replace any of the
> >>> lines after the plain access with the cached value.
> >> 
> >> Well, IIUC, according to the C standard, the compiler can do anything if there is a data race (undefined behavior).
> >> 
> >> However, what if a write is not protected with WRITE_ONCE and the read is marked with READ_ONCE?
> >> That’s also a data race, right? But the kernel considers it is Okay if the write is machine word aligned.
> > 
> > Yes, but there is a compiler between the HLL code and what the
> > processor sees which can tear the write. How can not using
> > WRITE_ONCE() prevent store-tearing? See [1]. My understanding is that
> > it is OK only if the reader did a NULL check. In that case the torn
> 
> Yes, a write-write data race where the value is the same is also fine.
> 
> But they are still data race, if the compiler is within its right to do anything it likes (due to data race),
> we still need WRITE_ONCE() in these cases, though it’s semantically safe.
> 
> IIUC, even with _ONCE(), the compiler is within its right do anything according to the standard (at least before the upcoming C23), because the standard doesn’t consider a volatile access to be atomic.

Volatile accesses are not specified very well in the standard.  However,
as a practical matter, compilers that wish to be able to device drivers
(whether in kernels or userspace applications) must compile those volatile
accesses in such a way to allow reliable device drivers to be written.

> However, the kernel consider the volatile access to be atomic, right?

The compiler must therefore act as if a volatile access to an aligned
machine-word size location is atomic.  To see this, consider accesses
to memory that is shared by a device driver and that device's firmware,
both of which are written in either C or C++.

Does that help?

							Thanx, Paul

> BTW, line 5 in the example is likely to be optimized away. And yes, the compiler can cache the value loaded from line 5 from the perspective of undefined behavior, even if I believe it would be a compiler bug from the perspective of kernel.
> 
> > result will not change the semantics of the program. But otherwise,
> > that's bad.
> > 
> > [1] https://lwn.net/Articles/793253/#Store%20Tearing
> > 
> > thanks,
> > 
> > - Joel
> > 
> > 
> >> 
> >>> 
> >>> Thanks.
> >>> 
> >>> 
> >>> 
> >>>> 
> >>>>> +plain accesses of a memory location with rcu_dereference() of the same memory
> >>>>> +location, in code involved in a data race.
> >>>>> +
> >>>>> In short, updaters use rcu_assign_pointer() and readers use
> >>>>> rcu_dereference(), and these two RCU API elements work together to
> >>>>> ensure that readers have a consistent view of newly added data elements.
> >>>>> --
> >>>>> 2.41.0.585.gd2178a4bd4-goog
> 
> 
