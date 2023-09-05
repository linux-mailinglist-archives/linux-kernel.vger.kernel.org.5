Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6387931E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbjIEWWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjIEWWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:22:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE0191;
        Tue,  5 Sep 2023 15:22:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA676C433C8;
        Tue,  5 Sep 2023 22:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693952549;
        bh=8YMYHkyZiAhmJ6syQzQUheL3bNZAGl1TBDnFPJ0oIRA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cS1rto+KUZQR80agwkIXGYjTxBddvUTSRVNsRnBz6OCUhBYAxWcqojyjfBd6DJ+ib
         YGbS6HtA0WjFrtKMhJffxUnUSWGDixfW4gtRTd6CER96HTTqL/xHBabV6DD68/U60v
         jnZQEjdhl0Zj1Cs6prs4vt4VmzdKL3mfuKzWR2Uo2yeqCIAR1CWUzKKAdJdHeqF27u
         Y0smuBneec+FNqKkaVYljHYaQ3IPukBs4Qn1HJjrIKkguUllc2HRU2ERNOXcr2l/o0
         8X/qCc7jiMXiaNXGzKtmpesdvNtEfJSC2+IiIXHXgspCmlhAZ46I2YhzuFZq1s71db
         A1i1NwS9QBb2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9A692CE0FF4; Tue,  5 Sep 2023 15:22:28 -0700 (PDT)
Date:   Tue, 5 Sep 2023 15:22:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Laight <David.Laight@aculab.com>,
        Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>, ldufour@linux.ibm.com
Subject: Re: [PATCH v2] The value may overflow
Message-ID: <285f9ee6-2f45-4b5a-8cd8-92b6f3b017a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b79eb142-67b2-48f0-9ad9-f9b634491e09@paulmck-laptop>
 <c312066b2cc44919bd11b6cd938cb05f@AcuMS.aculab.com>
 <ce51b768-9988-197c-0c35-7574aba77810@efficios.com>
 <abe14f37-ec05-48c3-87fc-9294848d221f@paulmck-laptop>
 <83422425-0534-4b12-a6e4-8068b7164a17@paulmck-laptop>
 <d2a3456b-aee9-f5b0-f8e4-5c5030c3217f@efficios.com>
 <b561c3a9-dc70-4c3d-b561-3f24398b01d8@paulmck-laptop>
 <CAEXW_YSe=s9S8OirDJARPvOrGUNXVPBkhucx5iKysjVk=AcLYg@mail.gmail.com>
 <a51db423-722c-43ab-9182-00f64c460043@paulmck-laptop>
 <CAEXW_YQW_0RD5mmtwnzwik9Q9K9XL9rxHUyb98SLqCJ-840xOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQW_0RD5mmtwnzwik9Q9K9XL9rxHUyb98SLqCJ-840xOQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 04:56:12PM -0400, Joel Fernandes wrote:
> On Tue, Sep 5, 2023 at 4:52 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Sep 05, 2023 at 04:40:46PM -0400, Joel Fernandes wrote:
> [...]
> > > > > > > So this bug appears to have no effect for default RCU setups, even on very
> > > > > > > large 64-bit systems, which is consistent with field experience.  Even if
> > > > > > > this is the case, it still should be fixed, to avoid confusion if nothing
> > > > > > > else.  Or just in case someone decides to set CONFIG_RCU_FANOUT_LEAF=32.
> > > > > > > Which actually happened the other day due to someone trusting ChatGPT's
> > > > > > > opinion about RCU Kconfig options...
> > > > > >
> > > > > > And I therefore queued Denis's v3 patch with an edited commit log.
> > > > > > Of course, if anyone sees some other way that the bug could manifest
> > > > > > other than in a 64-bit kernel built with CONFIG_RCU_FANOUT_LEAF greater
> > > > > > than 30 on a system with at least 31 CPUs, please let me know so that
> > > > > > I can adjust.
> > > > > >
> > > > > >                                                     Thanx, Paul
> > > > > >
> > > > > > ------------------------------------------------------------------------
> > > > > >
> > > > > > commit ed083b0e22f1396dee3599896249a3f218845298
> > > > > > Author: Denis Arefev <arefev@swemel.ru>
> > > > > > Date:   Mon Sep 4 15:21:14 2023 +0300
> > > > > >
> > > > > >      Fix srcu_struct node grpmask overflow on 64-bit systems
> > > > > >      The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
> > > > >
> > > > > AFAIU, the overflow resides in the "bitwise expression" and not
> > > > > the arithmetic expression.
> > > >
> > > > Rather than quibble about exactly what constitutes arithmetic, I
> > > > updated the first paragraph and added your Reviewed-by as shown
> > > > below.  ;-)
> > > >
> > > > > Other than this, please add my
> > > > >
> > > > > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > >
> > > > Thank you all!!!
> > > >
> > > > ------------------------------------------------------------------------
> > > >
> > > > commit 50477ff756ab99402b1523b7c6be8b5d790d05e7
> > > > Author: Denis Arefev <arefev@swemel.ru>
> > > > Date:   Mon Sep 4 15:21:14 2023 +0300
> > > >
> > > >     Fix srcu_struct node grpmask overflow on 64-bit systems
> > > >
> > > >     The value of a bitwise expression 1 << (cpu - sdp->mynode->grplo)
> > > >     is subject to overflow due to a failure to cast operands to a larger
> > > >     data type before performing the bitwise operation.
> > > >
> > > >     The maximum result of this subtraction is defined by the RCU_FANOUT_LEAF
> > > >     Kconfig option, which on 64-bit systems defaults to 16 (resulting in a
> > > >     maximum shift of 15), but which can be set up as high as 64 (resulting
> > > >     in a maximum shift of 63).  A value of 31 can result in sign extension,
> > > >     resulting in 0xffffffff80000000 instead of the desired 0x80000000.
> > > >     A value of 31 or greater triggers undefined behavior per the C standard.
> > >
> > > Do you mean here "A value of 32 or greater"?
> > >
> > > Only N >= 32 throws warning for:
> > > unsigned long foo = (1 << N);
> > >
> > > N=31 does undesirable sign extension but no warning.
> >
> > Good catch, thank you, and I will update this on my next rebase.
> 
> Thanks, and with that the patch looks good to me:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you very much, and I will apply this on the next rebase.

							Thanx, Paul
