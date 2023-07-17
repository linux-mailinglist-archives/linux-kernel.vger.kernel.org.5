Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6862756BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjGQSRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjGQSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE1E6C;
        Mon, 17 Jul 2023 11:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCDC611DF;
        Mon, 17 Jul 2023 18:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB8EC433C8;
        Mon, 17 Jul 2023 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689617807;
        bh=ZkG1DY9f2GypLSPk4E+7zlO8qVsaxvNixc+2Zkpr1xg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e642X59HxF5G3wNr08XvjGa0v7tLb408unc9QwKPY+HTeGN1o/GFFUZfFrj56Okiu
         jhHIW4IEDqFkqG2FIWwp9tNY1RX9MwVZ2aXoV385tmyxxP+jHeJVRyCThuNeh4FST3
         QGWXGf8U7wLXM016lHznxn+1a21NriA+3AvPcfgLT3dyXeeAHc9R/Rn+59o7LuOztI
         yCtxs2XeX0ZYJxulKgxhIHFihvXpdVa0nFUNWmbJykbPuYhXOkgud/mops7hfPBVi8
         zzwYx7VTwqiRuJ/7Mah03WNaC2AjEMaG8v4dCTUgnjnIgLPLd2HxDAyE9aKNCL5222
         2FDslCSs8OgGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 003E2CE03F1; Mon, 17 Jul 2023 11:16:46 -0700 (PDT)
Date:   Mon, 17 Jul 2023 11:16:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        atthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH rcu 3/6] srcu,notifier: Remove #ifdefs in favor of SRCU
 Tiny srcu_usage
Message-ID: <e27ec83e-ab0c-4b46-b01d-4d1a5dd43b64@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-3-paulmck@kernel.org>
 <CAHk-=whqX8r3EaaO48dgi=wEBZxJETg1m67HrScRbH1FK7GTRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whqX8r3EaaO48dgi=wEBZxJETg1m67HrScRbH1FK7GTRw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 11:09:56AM -0700, Linus Torvalds wrote:
> On Mon, 17 Jul 2023 at 11:03, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > +// Dummy structure for srcu_notifier_head.
> > +struct srcu_usage {
> > +       char srcuu_dummy;
> > +};
> > +
> > +#define __SRCU_USAGE_INIT(name) { .srcuu_dummy = 0, }
> 
> You really should be able to just do
> 
>    struct srcu_usage { };
>    #define __SRCU_USAGE_INIT(name) { }
> 
> which is something we've done for ages for spinlocks in
> 
>     include/linux/spinlock_types_up.h
> 
> because while we had a gcc bug wrt empty structures, that was ages ago
> (ie "gcc-2.x").
> 
> See commit a1365647022e ("[PATCH] remove gcc-2 checks") from 2006.
> 
> So we've already had these kinds of empty dummy structs for literally
> over a decade in active use. Exactly so that you can avoid having to
> use #ifdef's etc, and can just always assume you have a spinlock, even
> if it doesn't generate any code or any data overhead.

Showing my age again, I guess.  ;-)

Thank you for the hint!  I will rework this as you suggest.

							Thanx, Paul
