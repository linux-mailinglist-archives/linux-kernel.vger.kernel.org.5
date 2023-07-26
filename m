Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682AE763AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjGZPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjGZPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D911B;
        Wed, 26 Jul 2023 08:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA3AE61B77;
        Wed, 26 Jul 2023 15:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2209CC433C7;
        Wed, 26 Jul 2023 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690385033;
        bh=BuT3BCRx45ezZIHZUz21rlRd7r+tjVifEZyeIukhjjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=phNkqt5zDpbdk6cQj58Vy0mI9l20M/5CaM6kb5KnhaxhAJGnDMumSiFH8BOGIUU5P
         ekZRv/D1Gu/FjCeAdmD8JDfwYX/Qf7cfuPtkyoYL3EL5/3R/nsHaVN/OfrMHW15+Ia
         qS81cJpoSzGMWlRpV3mRAW9Nt2oXrEXo/u1Og7NiWrq4k0eYoKu9e2BtJ7ymmULG8i
         P1C4/hXCUIwTZy8AyeN5q970fyJHPTdWkI4yGViY6QQcABkwZ9ruo6XsSjCsuPxCkI
         c1WugV/MH6xYRx6a1mWpo7x9gfCCyDwRgL8cgCieCU8FoIVG3ytqegUiA+x/rjKXPw
         NOaTvSJj65I9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E14B40516; Wed, 26 Jul 2023 12:23:50 -0300 (-03)
Date:   Wed, 26 Jul 2023 12:23:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        ThomasGleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: 'perf test sigtrap' failing on PREEMPT_RT_FULL
Message-ID: <ZME6hYXlti3FLZSM@kernel.org>
References: <ZMAtZ2t43GXoF6tM@kernel.org>
 <e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e368f2c848d77fbc8d259f44e2055fe469c219cf.camel@gmx.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 26, 2023 at 08:10:45AM +0200, Mike Galbraith escreveu:
> On Tue, 2023-07-25 at 17:15 -0300, Arnaldo Carvalho de Melo wrote:
> > Hi Marco, Peter,

> >         I got a report that 'perf test sigtrap' test failed on a
> > PREEMPT_RT_FULL kernel, one that had up to:

> > commit 97ba62b278674293762c3d91f724f1bb922f04e0
> > Author: Marco Elver <elver@google.com>
> > Date:   Thu Apr 8 12:36:01 2021 +0200

> >     perf: Add support for SIGTRAP on perf events
> > ...

> > [   52.848925] BUG: scheduling while atomic: perf/6549/0x00000002

> Had bf9ad37dc8a not been reverted due to insufficient beauty, you could
> trivially make the sigtrap test a happy camper (wart tested in tip-rt).

Yeah, I cherry-picked bf9ad37dc8a:

  Author: Oleg Nesterov <oleg@redhat.com>
  Date:   Tue Jul 14 14:26:34 2015 +0200

      signal, x86: Delay calling signals in atomic on RT enabled kernels

Applied your force_sig_delayed() call to send_sig_perf() and got:

  [root@nine ~]# perf test sigtrap
   73: Sigtrap                                                         : Ok
  [root@nine ~]#

Happy camper indeed.

[acme@nine linux]$ git log --oneline -5
24f75a478a32 (HEAD) signal, x86: Delay calling signals in atomic on RT enabled kernels
d37d728e9a66 (tag: v6.4-rt6, linux-rt-devel/linux-6.4.y-rt) v6.4-rt6
4d1139baae8b mm/page_alloc: Use write_seqlock_irqsave() instead write_seqlock() + local_irq_save().
dc93c1f07d48 seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
a3f6be6e5353 printk: Check only for migration in printk_deferred_*().
[acme@nine linux]$ git diff
diff --git a/kernel/signal.c b/kernel/signal.c
index 464e68a8a273..f186e0d85381 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1868,6 +1868,9 @@ int send_sig_perf(void __user *addr, u32 type, u64 sig_data)
                                     TRAP_PERF_FLAG_ASYNC :
                                     0;

+       if (force_sig_delayed(&info, current))
+               return 0;
+
        return send_sig_info(info.si_signo, &info, current);
 }

[acme@nine linux]$ uname -a
Linux nine 6.4.0-rt6+ #3 SMP PREEMPT_RT Wed Jul 26 11:46:12 -03 2023 x86_64 x86_64 x86_64 GNU/Linux
[acme@nine linux]$ perf test sigtrap
 71: Sigtrap                                                         : Ok
[acme@nine linux]$

- Arnaldo
 
> @@ -1829,6 +1869,9 @@ int send_sig_perf(void __user *addr, u32
>  				     TRAP_PERF_FLAG_ASYNC :
>  				     0;
> 
> +	if (force_sig_delayed(&info, current))
> +		return 0;
> +
>  	return send_sig_info(info.si_signo, &info, current);
>  }
