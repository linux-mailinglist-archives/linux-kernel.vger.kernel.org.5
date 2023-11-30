Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFAA7FEFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjK3NBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjK3NBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:01:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5110DB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:01:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB402C433C9;
        Thu, 30 Nov 2023 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701349278;
        bh=Y6P2f2Sf3w01PljjdEzwHVXoK16hWzbz2lMqn3qVGR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWXQ3joRfXeJrQZePqk4Sy4pwHvenhlhyEYU//laRJSh9jGcSImZvKCGXH5VfJTk+
         RIK8uUK00872ap5RvtTxV2fWYMB+mlRV4HcMA/2lMTtwtjH8fuUouzhPULLTt25o/f
         SWGTedbcMK2Q+CkMvI9PLZOY1J04gfbxsEPt+CHU9Ur6GFQBoJ6z7AzrJx4VprIJYw
         pB6D+VP6Te6oVffUDdmFNUJvj4BDANnztdD9VGYS4trzylmXVPHOulJFfwOEBBonP+
         r5q0wxqJXXiyPnJE0I6+rDdB/XYdxc3Ovl32ZfHmhGAwM1Sfc+t7VXzef184lQwUsz
         35bqh3iSq+NcQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 79EE940094; Thu, 30 Nov 2023 10:01:15 -0300 (-03)
Date:   Thu, 30 Nov 2023 10:01:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] perf tests sigtrap: Skip if running on a kernel with
 sleepable spinlocks
Message-ID: <ZWiHm/RmtmOfQwVI@kernel.org>
References: <20231129154718.326330-1-acme@kernel.org>
 <20231129154718.326330-3-acme@kernel.org>
 <CANpmjNMftTuqPwmujNx5e+ajgdYtik9uL6dt62Ucotc7oz-uUw@mail.gmail.com>
 <ZWeiNj7B+5dJosE9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWeiNj7B+5dJosE9@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MANY_SUBDOM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 29, 2023 at 05:42:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Nov 29, 2023 at 04:57:47PM +0100, Marco Elver escreveu:
> > > @@ -175,7 +208,16 @@ static int run_stress_test(int fd, pthread_t *threads, pthread_barrier_t *barrie
> > >         ret = run_test_threads(threads, barrier);
> > >         TEST_ASSERT_EQUAL("disable failed", ioctl(fd, PERF_EVENT_IOC_DISABLE, 0), 0);

> > > -       TEST_ASSERT_EQUAL("unexpected sigtraps", ctx.signal_count, NUM_THREADS * ctx.iterate_on);
> > > +       expected_sigtraps = NUM_THREADS * ctx.iterate_on;

> > > +       if (ctx.signal_count < expected_sigtraps && kernel_with_sleepable_spinlocks()) {
> > > +               pr_debug("Expected %d sigtraps, got %d, running on a kernel with sleepable spinlocks.\n",
> > > +                        expected_sigtraps, ctx.signal_count);
> > > +               pr_debug("See https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/\n");

> > No changes from the RT side since? A fix exists, but apparently not
> > good enough... Sigh.

> Yeah, my impression, and first attempt at writing that patch wast that
> no sigtraps were being sent, but then when I tried with a random, more
> recent machine in the Red Hat labs, I got some signals, way less than
> the expected ones, but some, maybe this is an interesting data point?
 
> I'll try again to reproduce in the local machine, old i7 lenovo notebook
> and at the newer machine, a Xeon(R) Silver 4216, 32 cpu and report here.

So, on the i7 lenovo:

[root@nine ~]# uname -a
Linux nine 5.14.0-284.30.1.rt14.315.el9_2.x86_64 #1 SMP PREEMPT_RT Fri Aug 25 10:53:59 EDT 2023 x86_64 x86_64 x86_64 GNU/Linux
[root@nine ~]# grep "model name" /proc/cpuinfo
model name	: Intel(R) Core(TM) i7-2920XM CPU @ 2.50GHz
model name	: Intel(R) Core(TM) i7-2920XM CPU @ 2.50GHz
model name	: Intel(R) Core(TM) i7-2920XM CPU @ 2.50GHz
model name	: Intel(R) Core(TM) i7-2920XM CPU @ 2.50GHz
model name	: Intel(R) Core(TM) i7-2920XM CPU @ 2.50GHz
model name	: Intel(R) Core(TM) i7-2920XM CPU @ 2.50GHz
model name	: Intel(R) Core(TM) i7-2920XM CPU @ 2.50GHz
model name	: Intel(R) Core(TM) i7-2920XM CPU @ 2.50GHz
[root@nine ~]# grep "model name" /proc/cpuinfo  | wc -l
8
[root@nine ~]#
[root@nine ~]# perf test -v sigtrap
 68: Sigtrap                                                         :
--- start ---
test child forked, pid 77679
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
See https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/
test child finished with -2
---- end ----
Sigtrap: Skip
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# perf test -v sigtrap |& grep Expected
Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# uname -a

Consistently 0 sigtraps delivered:

[root@nine ~]# for a in $(seq 100) ; do perf test -v sigtrap |& grep Expected ; done | sort | uniq -c
    100 Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]# for a in $(seq 1000) ; do perf test -v sigtrap |& grep Expected ; done | sort | uniq -c
   1000 Expected 15000 sigtraps, got 0, running on a kernel with sleepable spinlocks.
[root@nine ~]#

While on the bigger machine:

[root@perf160 ~]# uname -a
Linux perf160.perf.lab.eng.bos.redhat.com 5.14.0-362.8.1.el9_3.x86_64+rt #1 SMP PREEMPT_RT Tue Oct 3 10:26:54 EDT 2023 x86_64 x86_64 x86_64 GNU/Linux
[root@perf160 ~]#

[acme@perf160 ~]$ grep "model name" /proc/cpuinfo  | wc -l
32
[acme@perf160 ~]$ grep "model name" /proc/cpuinfo | head -1
model name	: Intel(R) Xeon(R) Silver 4216 CPU @ 2.10GHz
[acme@perf160 ~]$
[acme@perf160 ~]$ perf test -v sigtrap
 68: Sigtrap                                                         :
--- start ---
test child forked, pid 72084
Expected 15000 sigtraps, got 1845, running on a kernel with sleepable spinlocks.
See https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/
test child finished with -2
---- end ----
Sigtrap: Skip
[acme@perf160 ~]$ perf test -v sigtrap
 68: Sigtrap                                                         :
--- start ---
test child forked, pid 72091
Expected 15000 sigtraps, got 2060, running on a kernel with sleepable spinlocks.
See https://lore.kernel.org/all/e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de/
test child finished with -2
---- end ----
Sigtrap: Skip
[acme@perf160 ~]$

[root@perf160 ~]# for a in $(seq 100) ; do perf test -v sigtrap |& grep Expected ; done | sort | uniq -c | sort -n
      1 Expected 15000 sigtraps, got 1010, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1064, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1139, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1165, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1166, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1177, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1206, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1279, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1321, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1359, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1368, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1400, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1432, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1490, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1520, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1527, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1532, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1566, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1597, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1600, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1630, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1652, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1689, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1706, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1709, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1753, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1765, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1778, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1830, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1896, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1901, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1903, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1908, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1909, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1930, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1951, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1976, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 1980, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2010, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2012, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2071, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2075, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2166, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2169, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2185, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2189, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2229, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2241, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2249, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2297, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2303, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2313, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2325, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2326, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2350, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2359, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2378, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2448, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2479, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2480, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2489, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2501, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2569, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2573, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2597, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2605, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2639, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2647, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2719, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2754, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2804, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2805, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2860, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 2882, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3152, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3177, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3179, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3249, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3261, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3332, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3388, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3395, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3465, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3487, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3622, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3677, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3782, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 3901, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 4087, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 4235, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 4372, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 4570, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 571, running on a kernel with sleepable spinlocks.
      1 Expected 15000 sigtraps, got 622, running on a kernel with sleepable spinlocks.
      2 Expected 15000 sigtraps, got 1929, running on a kernel with sleepable spinlocks.
      2 Expected 15000 sigtraps, got 1967, running on a kernel with sleepable spinlocks.
      2 Expected 15000 sigtraps, got 2072, running on a kernel with sleepable spinlocks.
[root@perf160 ~]# 

I guess I'll try to get hold of the older kernel with 0 sigtraps to see
if I get the same behaviour (consistent 0 sigtraps) on that kernel on
the bigger machine :-\

- Arnaldo
