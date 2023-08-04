Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6377069B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHDRDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjHDRDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60214ED8;
        Fri,  4 Aug 2023 10:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4700E620B6;
        Fri,  4 Aug 2023 17:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B1BC433C7;
        Fri,  4 Aug 2023 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691168555;
        bh=qs+QIUdxIFzWyrOJasFngXnPWrwLq+ttceEWpfXB7gA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Dfobvzeom7UUgAciwwnr1JIJaz0EGNd19anbt3F12V6m7EFWQ7f4DOqLjd1JwyN5F
         w+laxEkHXag5X+37j3sXmiX0DNLnK9cgXLmd4AZBtKDac936ewuqiwfchAvB0PcFFt
         2cnOGPBJyYwq6nCW5MGDPu847k4b9AnYSK7NbTIob6sI/0o2gMkNF29qhDE2qUiKkm
         azct+rjEaAumtoBKHA6dxrSc+PIgAR1HU8I74gQv8ExNBRGe68W96m2XOC8eqfRZeH
         A+UyRU/6FlphkH0gBLQ3fUvz7rrohF3uwSG3rJayHTg6ek6YOSJSMBZ2MdJt8VuxBA
         xnJhm6TaPqh5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D49ACE0591; Fri,  4 Aug 2023 10:02:35 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:02:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Huang <mmpgouride@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, Will Deacon <will@kernel.org>,
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
Message-ID: <81d02e70-a05d-4230-9b86-0026d4874ea7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f5652b1a-de71-4881-8825-fedd73544f54@paulmck-laptop>
 <D594A2D8-0C46-402D-B186-39DE7B65ED61@joelfernandes.org>
 <b8fd5f26-f101-4b58-aa62-649996b6ac5e@paulmck-laptop>
 <CAEXW_YQQsFiVqihOXN1pCtvvek4OBmphDR6D4gGFKkd4x9DQxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQQsFiVqihOXN1pCtvvek4OBmphDR6D4gGFKkd4x9DQxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:17:58PM -0400, Joel Fernandes wrote:
> [...]
> > > >> However, the kernel consider the volatile access to be atomic, right?
> > > >
> > > > The compiler must therefore act as if a volatile access to an aligned
> > > > machine-word size location is atomic.  To see this, consider accesses
> > > > to memory that is shared by a device driver and that device's firmware,
> > > > both of which are written in either C or C++.
> > >
> > > Btw it appears TSAN complaints bitterly on even volatile 4 byte data races.
> > > Hence we have to explicitly use atomic API for data race accesses in Chrome.
> >
> > That might have been a conscious and deliberate choice on the part of
> > the TSAN guys.  Volatile does not imply any ordering in the standard
> > (other than the compiler avoiding emitting volatile operations out of
> > order), but some compilers did emit memory-barrier instructions for
> > volatile accesses.  Which resulted in a lot of problems when such code
> > found compilers that did not cause the CPU to order volatile operations.
> >
> > So a lot of people decided to thrown the volatile baby out with the
> > unordered bathwather.  ;-)
> 
> Thanks for the input, I think TSAN was indeed worried about
> memory-ordering even if relaxed ordering was intended. I think there
> is a way to tell TSAN to shut-up in such situations but in my last
> Chrome sprint, I just used the atomic API with relaxed ordering and
> called it a day. :-)

Fair enough!

Note that the Linux kernel's version of TSAN, which is KCSAN, does
interpret volatile accesses more or less as if they were relaxed atomics.

So TSAN could change, but I don't have a dog in that fight.  ;-)

							Thanx, Paul
