Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5734E7BE217
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376850AbjJIOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbjJIOHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:07:37 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA58E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5y3Xsrg6mk7ndh55t4FBA+9rbjhoIzV35V6eekUHwTo=;
  b=VZ3p57vBdFg3cnHKD/TzCH/AydoKIMd8h2aFWeZ6dXdAyygoMlolMMpw
   1HmoYhHGxBUZMjm5EWxdP7cyGS+pp+XeEaKg2N79TJY8O0bURTngtRcjX
   5ERGyAs4wodpK7W5Mps8wiBAiZMDEfR+f1uB48hAKqcYAMKFdwlPt6q29
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,210,1694728800"; 
   d="scan'208";a="130251998"
Received: from wifi-eduroam-84-160.paris.inria.fr ([128.93.84.160])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 16:07:32 +0200
Date:   Mon, 9 Oct 2023 16:07:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <20231009102949.GC14330@noisy.programming.kicks-ass.net>
Message-ID: <e4a382dd-b6e5-5f47-45b-17c59b2cc48f@inria.fr>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <20231003215159.GJ1539@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041358420.3108@hadrien> <20231004120544.GA6307@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
 <20231004174801.GE19999@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041958380.3108@hadrien> <20231009102949.GC14330@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Oct 2023, Peter Zijlstra wrote:

> On Wed, Oct 04, 2023 at 08:04:34PM +0200, Julia Lawall wrote:
> > > I'll go build the benchmark thing tomorrow, if I can figure out how that
> > > works, this NAS stuff looked 'special'. Nothing simple like ./configure;
> > > make -j$lots :/
> >
> > Starting from git clone, I had to do:
> >
> > cd NPB3.4-OMP
> > mkdir bin
> > cd config
> > cp make.def.template make.def
> > cd ..
> > make ua CLASS=C
> >
> > You also need gfortran to be installed.
>
> W00t, that worked like a charm.
>
> The sad new is that I can't seem to reproduce the issue:
>
> So my (freshly re-installed with debian testing) 4 socket Intel(R)
> Xeon(R) CPU E7-8890 v3 machine gives me:
>
> root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# uname -a
> Linux hsw-ex 6.6.0-rc4+ #2 SMP PREEMPT_DYNAMIC Mon Oct  9 11:14:21 CEST 2023 x86_64 GNU/Linux
> root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# cat /proc/sys/kernel/numa_balancing
> 1
> root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# ./ua.C.x | grep "Time in seconds"
>  Time in seconds =                    26.69
> root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# ./ua.C.x | grep "Time in seconds"
>  Time in seconds =                    26.31
> root@hsw-ex:/usr/local/src/nas-parallel-benchmarks/NPB3.4-OMP/bin# ./ua.C.x | grep "Time in seconds"
>  Time in seconds =                    25.43

How many runs did you try?  I would suggest 50.

25-26 looks like what I get when things go well.

julia

>
>
> And this is using a .config very near what Debian ships for 6.5 (make
> olddefconfig -CONFIG_DEBUG_INFO_BTF)
>
> I'll try again in a little bit, perhaps I'm suffering PEBKAC :-)
>
>
>
