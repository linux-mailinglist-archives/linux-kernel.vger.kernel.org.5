Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9D75403E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjGNRNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjGNRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:13:35 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855C2683
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:13:06 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-440d1ba5662so635146137.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689354785; x=1691946785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1A1GrAlneerIyvakhZuMzzwwsvzd2DQ1TliaqqB0qMU=;
        b=fQvX3c3nfIvTtoyhax2d/rH096WBgvbTDzmX/bHe36MNV2McZZkex15bYpYesbnfGC
         MXoHF1fteEMDXynNNEvAYvhFmBUQuB7WtD1WP7Ta3m/bU0WojvWLnFubSjO1Jtfhl4II
         15Fwg9RaE/oQ9zh0lFBP0K6495fuPENEhZAEKylXZk/LgVFwgQvAuZcXjqC2zUrpLCMy
         suZJ2dEMNyrvkmdljhRXjfjqyRfEhBQJdnfUsLSH0eT8VCNowcHSfUVlILNWiO5iofeV
         o9ikVtt6CXg3G4umJeea5ivRSgNeJScbdSTn+UL7JtbRpXRFDIopbQH4If6l/e7dKq8r
         u9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689354785; x=1691946785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1A1GrAlneerIyvakhZuMzzwwsvzd2DQ1TliaqqB0qMU=;
        b=OMqPOYPBTZXHBrujCsIrNG1/1t6MA8Eia6nY5DbgxwnGUCd2H4vVdYxgMw3Itmvir3
         6IxiV23TCYAwWQqZ/BKKZBBPCr8wHfRbb1IpjobxeOTJgTmyA0rVum0RxSh8wPJ+GRP4
         Gg/lqLHHVox2hwnpcKvE0iwH2wU1/grF0k1i3Yi5kJ7Qd7EVgNabVSGTyrMIOCSKuVdM
         TJP6WxPLJ6fnNIrRtdhCkuNXJzIBQxXDV4n/Lzx2wxF8NB/i/24TpqIB2fmTgSRuJIMx
         /9cXtJRgsQYIzDZC34Q5PmbZMDBWzJOQ3DTfRsmX0DMzNUtx4U/0L/b0qYnHjefbiJeK
         Pt0g==
X-Gm-Message-State: ABy/qLZNmUV8ePytJug9QJkWAQh7DPtNXe2viEr+Lq62jc+IQbf90IWT
        GdKHAtPPVbYqHWMSS+vozXVAgCJx8oqHmaAaY9k=
X-Google-Smtp-Source: APBJJlFba3Y6LAT2ICUs0+o+Lr7blr8a5yHMRQxIOtiyqw/paUTCZWFKi5Bdn5+w91lfJARctjWsF9tZ/VJamUqaBts=
X-Received: by 2002:a67:eec7:0:b0:444:c7fa:15e6 with SMTP id
 o7-20020a67eec7000000b00444c7fa15e6mr2117672vsp.9.1689354784601; Fri, 14 Jul
 2023 10:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230707161052.GF2883469@hirez.programming.kicks-ass.net>
In-Reply-To: <20230707161052.GF2883469@hirez.programming.kicks-ass.net>
From:   Henry Wu <triangletrap12@gmail.com>
Date:   Sat, 15 Jul 2023 01:12:53 +0800
Message-ID: <CAG-UpRR74X8dnog1HcWpmkE4ctZcuaR2FvGZoqpuXMaGzrKNDg@mail.gmail.com>
Subject: Re: [PATCH] locking/rtmutex: Fix task->pi_waiters integrity
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: multipart/mixed; boundary="000000000000d60f100600758f88"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d60f100600758f88
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, all.

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=888=E6=
=97=A5=E5=91=A8=E5=85=AD 00:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Henry reported that rt_mutex_adjust_prio_check() has an ordering
> problem and puts the lie to the comment in [7]. Sharing the sort key
> between lock->waiters and owner->pi_waiters *does* create problems,
> since unlike what the comment claims, holding [L] is insufficient.
>
> Notably, consider:
>
>         A
>       /   \
>      M1   M2
>      |     |
>      B     C
>
> That is, task A owns both M1 and M2, B and C block on them. In this
> case a concurrent chain walk (B & C) will modify their resp. sort keys
> in [7] while holding M1->wait_lock and M2->wait_lock. So holding [L]
> is meaningless, they're different Ls.
>
> This then gives rise to a race condition between [7] and [11], where
> the requeue of pi_waiters will observe an inconsistent tree order.
>
>         B                               C
>
>   (holds M1->wait_lock,         (holds M2->wait_lock,
>    holds B->pi_lock)             holds A->pi_lock)
>
>   [7]
>   waiter_update_prio();
>   ...
>   [8]
>   raw_spin_unlock(B->pi_lock);
>   ...
>   [10]
>   raw_spin_lock(A->pi_lock);
>
>                                 [11]
>                                 rt_mutex_enqueue_pi();
>                                 // observes inconsistent A->pi_waiters
>                                 // tree order
>
> Fixing this means either extending the range of the owner lock from
> [10-13] to [6-13], with the immediate problem that this means [6-8]
> hold both blocked and owner locks, or duplicating the sort key.
>
> Since the locking in chain walk is horrible enough without having to
> consider pi_lock nesting rules, duplicate the sort key instead.
>
> By giving each tree their own sort key, the above race becomes
> harmless, if C sees B at the old location, then B will correct things
> (if they need correcting) when it walks up the chain and reaches A.
>
> Fixes: fb00aca47440 ("rtmutex: Turn the plist into an rb-tree")
> Reported-by: Henry Wu <triangletrap12@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/locking/rtmutex.c        |  170 ++++++++++++++++++++++++++-------=
-------
>  kernel/locking/rtmutex_api.c    |    2
>  kernel/locking/rtmutex_common.h |   47 ++++++++---
>  kernel/locking/ww_mutex.h       |   12 +-
>  4 files changed, 155 insertions(+), 76 deletions(-)
>

Sorry for late reply due to overlooked your patch.

I tested your patch on a 6 core machine with kernel 6.5.0-rc1. It
works well and my test program can't find any race on patched kernel.

I tested it with non-debug kernel for almost 3 hours and tested with
debug kernel for 6 hours. I checked my dmesg and there was no
irregular log. I checked my test program on kernel 6.3.12 that it can
reproduce the race we discussed previously.

You can find my test program in attachment and below is test output.
You can add "Tested-by" in commit msg.

Thanks

Henry

For non-debug kernel:

$ sudo cat /sys/kernel/debug/sched/preempt
none voluntary (full)
$ sudo ./a.out
pid: 23845
Before: prio: 20
    PID     LWP TTY          TIME CMD
  23845   23845 pts/0    00:00:00 a.out
  23845   23846 pts/0    00:00:00 waiter-0
  23845   23847 pts/0    00:00:00 waiter-1
  23845   23848 pts/0    00:00:00 waiter-2
  23845   23849 pts/0    00:00:00 waiter-3
  23845   23850 pts/0    00:00:00 waiter-4
  23845   23851 pts/0    00:00:00 waiter-5
  23845   23852 pts/0    00:00:00 waiter-6
  23845   23853 pts/0    00:00:00 waiter-7
  23845   23854 pts/0    00:00:00 waiter-8
  23845   23855 pts/0    00:00:00 waiter-9
  23845   23856 pts/0    00:00:00 waiter-10
  23845   23857 pts/0    00:00:00 waiter-11
  23845   23858 pts/0    00:00:00 waiter-12
  23845   23859 pts/0    00:00:00 waiter-13
  23845   23860 pts/0    00:00:00 waiter-14
  23845   23861 pts/0    00:00:00 waiter-15
  23845   23862 pts/0    00:00:00 waiter-16
  23845   23863 pts/0    00:00:00 waiter-17
  23845   23864 pts/0    00:00:00 waiter-18
  23845   23865 pts/0    00:00:00 waiter-19
  23845   23866 pts/0    00:00:00 changer-0
  23845   23867 pts/0    00:00:00 changer-1
  23845   23868 pts/0    00:00:00 changer-2
  23845   23869 pts/0    00:00:00 changer-3
  23845   23870 pts/0    00:00:00 changer-4
  23845   23871 pts/0    00:00:00 changer-5
  23845   23872 pts/0    00:00:00 changer-6
  23845   23873 pts/0    00:00:00 changer-7
  23845   23874 pts/0    00:00:00 changer-8
  23845   23875 pts/0    00:00:00 changer-9
  23845   23876 pts/0    00:00:00 changer-10
  23845   23877 pts/0    00:00:00 changer-11
  23845   23878 pts/0    00:00:00 changer-12
  23845   23879 pts/0    00:00:00 changer-13
  23845   23880 pts/0    00:00:00 changer-14
  23845   23881 pts/0    00:00:00 changer-15
  23845   23882 pts/0    00:00:00 changer-16
  23845   23883 pts/0    00:00:00 changer-17
  23845   23884 pts/0    00:00:00 changer-18
  23845   23885 pts/0    00:00:00 changer-19
Prio: -21, elapsed: 2.0 minutes.
Prio: -21, elapsed: 4.0 minutes.
Prio: -21, elapsed: 6.0 minutes.
.............
Prio: -21, elapsed: 166.0 minutes.
Prio: -21, elapsed: 168.0 minutes.
Prio: -21, elapsed: 170.0 minutes.
Prio: -21, elapsed: 172.0 minutes.
Prio: -21, elapsed: 174.0 minutes.

For debug kernel:

$ uname -a
Linux fedora 6.5.0-0.rc1.20230713gteb26cbb1.213.rtmutex.fc38.x86_64+debug
#1 SMP PREEMPT_DYNAMIC Fri Jul 14 14:49:04 CST 2023 x86_64 GNU/Linux
$ sudo cat /sys/kernel/debug/sched/preempt
none voluntary (full)
$ gcc -Wall -g ./pi_650_rc1.c
$ sudo ./a.out
pid: 3141
Before: prio: 20
    PID     LWP TTY          TIME CMD
   3141    3141 pts/0    00:00:00 a.out
   3141    3142 pts/0    00:00:00 waiter-0
   3141    3143 pts/0    00:00:00 waiter-1
   3141    3144 pts/0    00:00:00 waiter-2
   3141    3145 pts/0    00:00:00 waiter-3
   3141    3146 pts/0    00:00:00 waiter-4
   3141    3147 pts/0    00:00:00 waiter-5
   3141    3148 pts/0    00:00:00 waiter-6
   3141    3149 pts/0    00:00:00 waiter-7
   3141    3150 pts/0    00:00:00 waiter-8
   3141    3151 pts/0    00:00:00 waiter-9
   3141    3152 pts/0    00:00:00 waiter-10
   3141    3153 pts/0    00:00:00 waiter-11
   3141    3154 pts/0    00:00:00 waiter-12
   3141    3155 pts/0    00:00:00 waiter-13
   3141    3156 pts/0    00:00:00 waiter-14
   3141    3157 pts/0    00:00:00 waiter-15
   3141    3158 pts/0    00:00:00 waiter-16
   3141    3159 pts/0    00:00:00 waiter-17
   3141    3160 pts/0    00:00:00 waiter-18
   3141    3161 pts/0    00:00:00 waiter-19
   3141    3162 pts/0    00:00:00 changer-0
   3141    3163 pts/0    00:00:00 changer-1
   3141    3164 pts/0    00:00:00 changer-2
   3141    3165 pts/0    00:00:00 changer-3
   3141    3166 pts/0    00:00:00 changer-4
   3141    3167 pts/0    00:00:00 changer-5
   3141    3168 pts/0    00:00:00 changer-6
   3141    3169 pts/0    00:00:00 changer-7
   3141    3170 pts/0    00:00:00 changer-8
   3141    3171 pts/0    00:00:00 changer-9
   3141    3172 pts/0    00:00:00 changer-10
   3141    3173 pts/0    00:00:00 changer-11
   3141    3174 pts/0    00:00:00 changer-12
   3141    3175 pts/0    00:00:00 changer-13
   3141    3176 pts/0    00:00:00 changer-14
   3141    3177 pts/0    00:00:00 changer-15
   3141    3178 pts/0    00:00:00 changer-16
   3141    3179 pts/0    00:00:00 changer-17
   3141    3180 pts/0    00:00:00 changer-18
   3141    3181 pts/0    00:00:00 changer-19
Prio: -21, elapsed: 2.0 minutes.
Prio: -21, elapsed: 4.0 minutes.
Prio: -21, elapsed: 6.0 minutes.
Prio: -21, elapsed: 8.0 minutes.
Prio: -21, elapsed: 10.0 minutes.
Prio: -21, elapsed: 12.0 minutes.
Prio: -21, elapsed: 14.0 minutes.
....................
Prio: -21, elapsed: 388.0 minutes.
Prio: -21, elapsed: 390.0 minutes.
Prio: -21, elapsed: 392.0 minutes.
Prio: -21, elapsed: 394.0 minutes.
Prio: -21, elapsed: 396.0 minutes.
^C
$

--000000000000d60f100600758f88
Content-Type: text/x-csrc; charset="US-ASCII"; name="pi_650_rc1.c"
Content-Disposition: attachment; filename="pi_650_rc1.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lk2u2zzm0>
X-Attachment-Id: f_lk2u2zzm0

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGFzc2VydC5oPgojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3Rk
aW50Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxl
cnJuby5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KCiNkZWZpbmUgUENPVU5UIDIwCiNkZWZp
bmUgRVhQRUNURURfUFJJTyAtMjEKCi8vIENvcGllZCBmcm9tIHJlbGF0ZWQgaGVhZGVyLgpzdHJ1
Y3Qgc2NoZWRfYXR0ciB7Cgl1aW50MzJfdCBzaXplOwoKCXVpbnQzMl90IHNjaGVkX3BvbGljeTsK
CXVpbnQ2NF90IHNjaGVkX2ZsYWdzOwoKCS8qIFNDSEVEX05PUk1BTCwgU0NIRURfQkFUQ0ggKi8K
CWludDMyX3Qgc2NoZWRfbmljZTsKCgkvKiBTQ0hFRF9GSUZPLCBTQ0hFRF9SUiAqLwoJdWludDMy
X3Qgc2NoZWRfcHJpb3JpdHk7CgoJLyogU0NIRURfREVBRExJTkUgKi8KCXVpbnQ2NF90IHNjaGVk
X3J1bnRpbWU7Cgl1aW50NjRfdCBzY2hlZF9kZWFkbGluZTsKCXVpbnQ2NF90IHNjaGVkX3Blcmlv
ZDsKCgkvKiBVdGlsaXphdGlvbiBoaW50cyAqLwoJdWludDMyX3Qgc2NoZWRfdXRpbF9taW47Cgl1
aW50MzJfdCBzY2hlZF91dGlsX21heDsKfTsKCnN0YXRpYyBwdGhyZWFkX211dGV4X3QgbXV0ZXhl
c1tQQ09VTlRdOwoKc3RhdGljIHZvaWQgaW5pdF9tdXRleChwdGhyZWFkX211dGV4X3QgKm11dGV4
KSB7CglwdGhyZWFkX211dGV4YXR0cl90IGF0dHI7CglpbnQgcmV0OwoKCXJldCA9IHB0aHJlYWRf
bXV0ZXhhdHRyX2luaXQoJmF0dHIpOwoJYXNzZXJ0KCFyZXQpOwoJcmV0ID0gcHRocmVhZF9tdXRl
eGF0dHJfc2V0cHJvdG9jb2woJmF0dHIsIFBUSFJFQURfUFJJT19JTkhFUklUKTsKCWFzc2VydCgh
cmV0KTsKCglyZXQgPSBwdGhyZWFkX211dGV4X2luaXQobXV0ZXgsICZhdHRyKTsKCWFzc2VydCgh
cmV0KTsKCglwdGhyZWFkX211dGV4YXR0cl9kZXN0cm95KCZhdHRyKTsKfQoKZW51bSB0aHJlYWRf
dHlwZSB7CglXQUlURVIsCglQUklPX0NIQU5HRVIsCn07CgpzdGF0aWMgc3RydWN0IHRocmVhZF9z
cGVjIHsKCWVudW0gdGhyZWFkX3R5cGUgdHlwZTsKCWludCBuYW1lX2luZGV4OwoJcHRocmVhZF9i
YXJyaWVyX3QgKmJhcnJpZXI7CgoJLy8gVXNlZCBieSB3YWl0ZXIuCglwdGhyZWFkX211dGV4X3Qg
KndhaXRfbXV0ZXg7CglwaWRfdCBwaWRfc2F2ZTsKCQoJLy8gVXNlZCBieSBwcmlvIGNoYW5nZXIu
CglwaWRfdCAqd2FpdGVyX3BpZDsKCXVpbnQzMl90IHByaW87Cn0gdGhyZWFkX3NwZWNzW1BDT1VO
VCAqIDJdOwoKc3RhdGljIHB0aHJlYWRfdCB0aHJlYWRzW1BDT1VOVCAqIDJdOwpzdGF0aWMgaW50
IHRocmVhZF9jb3VudCA9IDA7CgpzdGF0aWMgaW50IGJhcnJpZXJfd2FpdChwdGhyZWFkX2JhcnJp
ZXJfdCAqYmFycmllcikgewoJaWYgKCFiYXJyaWVyKSB7CgkJcmV0dXJuIDA7Cgl9CgoJaW50IHJl
dCA9IHB0aHJlYWRfYmFycmllcl93YWl0KGJhcnJpZXIpOwoJYXNzZXJ0KCFyZXQgfHwgcmV0ID09
IFBUSFJFQURfQkFSUklFUl9TRVJJQUxfVEhSRUFEKTsKCglyZXR1cm4gcmV0Owp9CgpzdGF0aWMg
aW50IHNjaGVkX2dldGF0dHIocGlkX3QgcGlkLCBzdHJ1Y3Qgc2NoZWRfYXR0ciAqYXR0ciwgaW50
IGZsYWdzKSB7CglyZXR1cm4gc3lzY2FsbChTWVNfc2NoZWRfZ2V0YXR0ciwgcGlkLCBhdHRyLCBz
aXplb2YoKmF0dHIpLCBmbGFncyk7Cn0KCnN0YXRpYyBpbnQgc2NoZWRfc2V0YXR0cihwaWRfdCBw
aWQsIHN0cnVjdCBzY2hlZF9hdHRyICphdHRyLCBpbnQgZmxhZ3MpIHsKCXJldHVybiBzeXNjYWxs
KFNZU19zY2hlZF9zZXRhdHRyLCBwaWQsIGF0dHIsIGZsYWdzKTsKfQoKc3RhdGljIHZvaWQgKnBy
aW9fY2hhbmdlX2xvb3Aoc3RydWN0IHRocmVhZF9zcGVjICpzcGVjKSB7CglzdHJ1Y3Qgc2NoZWRf
YXR0ciBhdHRyOwoJaW50IHJldDsKCglmb3IgKDs7KSB7CgkJYmFycmllcl93YWl0KHNwZWMtPmJh
cnJpZXIpOwoKCQlyZXQgPSBzY2hlZF9nZXRhdHRyKCpzcGVjLT53YWl0ZXJfcGlkLCAmYXR0ciwg
MCk7CgkJaWYgKHJldCA8IDApIHsKCQkJcGVycm9yKCJzY2hlZF9nZXRhdHRyIik7CgkJCWFzc2Vy
dCgwKTsKCQl9CgkJCgkJYXR0ci5zY2hlZF9wb2xpY3kgPSBTQ0hFRF9SUjsKCQlhdHRyLnNjaGVk
X3ByaW9yaXR5ID0gc3BlYy0+cHJpbzsKCQoJCXJldCA9IHNjaGVkX3NldGF0dHIoKnNwZWMtPndh
aXRlcl9waWQsICZhdHRyLCAwKTsKCQlpZiAocmV0IDwgMCkgewoJCQlwZXJyb3IoInNjaGVkX3Nl
dGF0dHIiKTsKCQkJZXhpdCgxKTsKCQl9CgoJCWJhcnJpZXJfd2FpdChzcGVjLT5iYXJyaWVyKTsK
CX0KfQoKc3RhdGljIHZvaWQgKnRocmVhZCh2b2lkICphcmcpIHsKCXN0cnVjdCB0aHJlYWRfc3Bl
YyAqc3BlYyA9IGFyZzsKCWNoYXIgbmFtZVs2NF07CglpbnQgcmV0OwoJCglzbnByaW50ZihuYW1l
LCBzaXplb2YobmFtZSksICIlcy0lZCIsIAoJCQlzcGVjLT50eXBlID09IFdBSVRFUiA/ICJ3YWl0
ZXIiIDogImNoYW5nZXIiLCAKCQkJc3BlYy0+bmFtZV9pbmRleCk7CglyZXQgPSBwdGhyZWFkX3Nl
dG5hbWVfbnAocHRocmVhZF9zZWxmKCksIG5hbWUpOwoJYXNzZXJ0KCFyZXQpOwoKCXN3aXRjaCAo
c3BlYy0+dHlwZSkgewoJY2FzZSBXQUlURVI6CgkJc3BlYy0+cGlkX3NhdmUgPSBnZXR0aWQoKTsK
CgkJYmFycmllcl93YWl0KHNwZWMtPmJhcnJpZXIpOwoKCQlyZXQgPSBwdGhyZWFkX211dGV4X2xv
Y2soc3BlYy0+d2FpdF9tdXRleCk7CgkJYXNzZXJ0KCFyZXQpOwoJCWJyZWFrOwoJY2FzZSBQUklP
X0NIQU5HRVI6CgkJcHJpb19jaGFuZ2VfbG9vcChzcGVjKTsKCQlicmVhazsKCWRlZmF1bHQ6CgkJ
YXNzZXJ0KDApOwoJCWJyZWFrOwoJfQoKCXJldHVybiBOVUxMOwp9CgpzdGF0aWMgdm9pZCBjcmVh
dGVfdGhyZWFkKHN0cnVjdCB0aHJlYWRfc3BlYyAqc3BlYykgewoJaW50IHJldDsKCglyZXQgPSBw
dGhyZWFkX2NyZWF0ZSgmdGhyZWFkc1t0aHJlYWRfY291bnQrK10sIE5VTEwsIHRocmVhZCwgc3Bl
Yyk7Cglhc3NlcnQoIXJldCk7Cn0KCnN0YXRpYyBpbnQgZ2V0X3ByaW8oaW50IG5lZWRfcHJpbnQp
IHsKCUZJTEUgKmZpbGUgPSBmb3BlbigiL3Byb2Mvc2VsZi9zdGF0IiwgInIiKTsKCWFzc2VydChm
aWxlKTsKCgljaGFyIGNvbW1bNjRdOwoJaW50IHRtcCwgcHJpbywgcmV0OwoJcmV0ID0gZnNjYW5m
KGZpbGUsICIlZCAlcyAlYyAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAlZCAl
ZCAlZCIsCgkJCSZ0bXAsIGNvbW0sIGNvbW0sICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAs
ICZ0bXAsCgkJCSZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAsICZ0bXAs
ICZwcmlvKTsKCWFzc2VydChyZXQgPT0gMTgpOwoKCWlmIChuZWVkX3ByaW50KSB7CgkJcHJpbnRm
KCJwcmlvOiAlZFxuIiwgcHJpbyk7Cgl9CgoJZmNsb3NlKGZpbGUpOwoKCXJldHVybiBwcmlvOwp9
CgpzdGF0aWMgdm9pZCBwcmludF90aHJlYWRzKHBpZF90IHByb2Nlc3NfcGlkKSB7CgljaGFyIGNt
ZFsxMjhdOwoJc25wcmludGYoY21kLCBzaXplb2YoY21kKSwgInBzIC1MIC1wICVkIiwgcHJvY2Vz
c19waWQpOwoJc3lzdGVtKGNtZCk7Cn0KCmludCBtYWluKHZvaWQpIHsKCXBpZF90IHBpZDsKCWlu
dCByZXQ7CgoJcGlkID0gZ2V0cGlkKCk7CglwcmludGYoInBpZDogJWRcbiIsIHBpZCk7CgoJZm9y
IChpbnQgaSA9IDA7IGkgPCBzaXplb2YobXV0ZXhlcykgLyBzaXplb2YobXV0ZXhlc1swXSk7ICsr
aSkgewoJCWluaXRfbXV0ZXgoJm11dGV4ZXNbaV0pOwoJCXJldCA9IHB0aHJlYWRfbXV0ZXhfbG9j
aygmbXV0ZXhlc1tpXSk7CgkJYXNzZXJ0KCFyZXQpOwoJfQoKCXB0aHJlYWRfYmFycmllcl90IGJh
cnJpZXI7CglyZXQgPSBwdGhyZWFkX2JhcnJpZXJfaW5pdCgmYmFycmllciwgTlVMTCwgUENPVU5U
ICsgMSk7Cglhc3NlcnQoIXJldCk7CgoJZm9yIChpbnQgaSA9IDA7IGkgPCBQQ09VTlQ7ICsraSkg
ewoJCXN0cnVjdCB0aHJlYWRfc3BlYyAqc3BlYyA9ICZ0aHJlYWRfc3BlY3NbaV07CgkJCgkJc3Bl
Yy0+dHlwZSA9IFdBSVRFUjsKCQlzcGVjLT5uYW1lX2luZGV4ID0gaTsKCQlzcGVjLT53YWl0X211
dGV4ID0gJm11dGV4ZXNbaV07CgkJc3BlYy0+YmFycmllciA9ICZiYXJyaWVyOwoKCQljcmVhdGVf
dGhyZWFkKHNwZWMpOwoJfQoKCS8vIFdhaXQgZm9yIGZpbGxpbmcgb2YgcGlkX3NhdmUuCgliYXJy
aWVyX3dhaXQoJmJhcnJpZXIpOwoKCWZvciAoaW50IGkgPSAwOyBpIDwgUENPVU5UOyArK2kpIHsK
CQlzdHJ1Y3QgdGhyZWFkX3NwZWMgKnNwZWMgPSAmdGhyZWFkX3NwZWNzW2kgKyBQQ09VTlRdOwoK
CQlzcGVjLT50eXBlID0gUFJJT19DSEFOR0VSOyAKCQlzcGVjLT5uYW1lX2luZGV4ID0gaTsKCQlz
cGVjLT5wcmlvID0gOTk7CgkJc3BlYy0+YmFycmllciA9ICZiYXJyaWVyOwoJCXNwZWMtPndhaXRl
cl9waWQgPSAmdGhyZWFkX3NwZWNzW2ldLnBpZF9zYXZlOwoKCQljcmVhdGVfdGhyZWFkKHNwZWMp
OwoJfQoKCXByaW50ZigiQmVmb3JlOiAiKTsKCWdldF9wcmlvKDEpOwoJcHJpbnRfdGhyZWFkcyhw
aWQpOwoKCXRpbWVfdCB0cywgc3RhcnRfdHM7CglzcmFuZG9tKHRpbWUoJnRzKSk7CglzdGFydF90
cyA9IHRzOwoJaW50IGl0ZXIgPSAwOwoJZm9yICg7OykgewoJCSsraXRlcjsKCQlmb3IgKGludCBp
ID0gMDsgaSA8IFBDT1VOVDsgKytpKSB7CgkJCXRocmVhZF9zcGVjc1tpICsgUENPVU5UXS5wcmlv
ID0gKGl0ZXIgJSAyKSA/IGkgKyAxIDogUENPVU5UIC0gaTsKCQl9CgoJCWZvciAoaW50IGkgPSAw
OyBpIDwgUENPVU5UOyArK2kpIHsKCQkJaW50IHBvcyA9IHJhbmRvbSgpICUgUENPVU5UOwoJCQlp
bnQgdG1wID0gdGhyZWFkX3NwZWNzW3BvcyArIFBDT1VOVF0ucHJpbzsKCQkJdGhyZWFkX3NwZWNz
W3BvcyArIFBDT1VOVF0ucHJpbyA9IHRocmVhZF9zcGVjc1tQQ09VTlRdLnByaW87CgkJCXRocmVh
ZF9zcGVjc1tQQ09VTlRdLnByaW8gPSB0bXA7CgkJfQoKCQliYXJyaWVyX3dhaXQoJmJhcnJpZXIp
OwoJCWJhcnJpZXJfd2FpdCgmYmFycmllcik7CgoJCS8vc3lzdGVtKCJlY2hvIGl0ZXJhdGlvbiA+
IC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcvdHJhY2VfbWFya2VyIik7CgoJCWZvciAoaW50IHRy
eSA9IDA7IDsgKyt0cnkpIHsKCQkJaW50IHByaW8gPSBnZXRfcHJpbygwKTsKCQkJdGltZV90IG5v
dyA9IHRpbWUoTlVMTCk7CgkJCWlmIChub3cgLSB0cyA+PSAxMjApIHsKCQkJCXByaW50ZigiUHJp
bzogJWQsIGVsYXBzZWQ6ICUuMWYgbWludXRlcy5cbiIsIHByaW8sIChkb3VibGUpKG5vdyAtIHN0
YXJ0X3RzKSAvIDYwKTsKCQkJCXRzID0gbm93OwoJCQl9CgoJCQlpZiAocHJpbyA9PSBFWFBFQ1RF
RF9QUklPKSB7CgkJCQkvLyBUcnkgYSBuZXcgaXRlcmF0aW9uLgoJCQkJYnJlYWs7CgkJCX0KCgkJ
CWlmICh0cnkgPj0gMTApIHsKCQkJCXByaW50X3RocmVhZHMocGlkKTsKCQkJCXByaW50ZigiZm91
bmQgcmFjZSwgaGFuZy4uLlxuIik7CgkJCQl3aGlsZSAoMSkgewoJCQkJCXNsZWVwKDM2MDApOwoJ
CQkJfQoJCQl9CgkJfQoJfQoKCWZvciAoaW50IGkgPSAwOyBpIDwgdGhyZWFkX2NvdW50OyArK2kp
IHsKCQlwdGhyZWFkX2pvaW4odGhyZWFkc1tpXSwgTlVMTCk7Cgl9CgoJcmV0dXJuIDA7Cn0KCg==
--000000000000d60f100600758f88--
