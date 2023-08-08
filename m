Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90167745D1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjHHSqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjHHSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF7C467D8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691513199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWzwA+W72taS7miXvf1cLjjea0mO1B8Z+QWEVh83RO8=;
        b=XDrFQt4x1eSo/wuSzqZQ/glcNuJDtYneK878kNOEaWA4mykpsoYSXBPu9BuqJty1EVz8KF
        Ak3b+4GoqlE/T7hTIQNtDACCO5c2kLYcJI6MSMy+DRRwL0Oc1s8ACz8ZdzzrvH2uNaZUeo
        GKK1YqtiDbeWX7PEiwKKrr31V2FwQQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-z0PeCSxIMU-6SHPF6evmAQ-1; Tue, 08 Aug 2023 03:28:37 -0400
X-MC-Unique: z0PeCSxIMU-6SHPF6evmAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA240800159;
        Tue,  8 Aug 2023 07:28:36 +0000 (UTC)
Received: from localhost (unknown [10.42.28.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7994240C2076;
        Tue,  8 Aug 2023 07:28:36 +0000 (UTC)
Date:   Tue, 8 Aug 2023 08:28:35 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     John Stultz <jstultz@google.com>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Message-ID: <20230808072835.GT7636@redhat.com>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
 <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
 <20230704074620.GA17440@redhat.com>
 <20230705162830.GC17440@redhat.com>
 <20230705215008.GD17440@redhat.com>
 <c4b9f02f-3f6a-74b4-4e0d-3da314f90aa8@linaro.org>
 <20230706102823.GO7636@redhat.com>
 <CANDhNCpxw1rLj-PkD-AihnkNoeTu2a7_xSM=c0qs9ugyZCgJeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCpxw1rLj-PkD-AihnkNoeTu2a7_xSM=c0qs9ugyZCgJeQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 10:27:13PM -0700, John Stultz wrote:
> On Thu, Jul 6, 2023 at 3:28 AM Richard W.M. Jones <rjones@redhat.com> wrote:
> >
> > On Thu, Jul 06, 2023 at 07:30:50AM +0100, Richard Henderson wrote:
> > > On 7/5/23 22:50, Richard W.M. Jones wrote:
> > > >tb_invalidate_phys_range_fast() *is* called, and we end up calling
> > > >   tb_invalidate_phys_page_range__locked ->
> > > >     tb_phys_invalidate__locked ->
> > > >       do_tb_phys_invalidate
> > > >
> > > >Nevertheless the old TB (containing the call to the int3 helper) is
> > > >still called after the code has been replaced with a NOP.
> > > >
> > > >Of course there are 4 MTTCG threads so maybe another thread is in the
> > > >middle of executing the same TB when it gets invalidated.
> > >
> > > Yes.
> > >
> > > >tb_invalidate_phys_page_range__locked goes to some effort to check if
> > > >the current TB is being invalidated and restart the TB, but as far as
> > > >I can see the test can only work for the current core, and won't
> > > >restart the TB on other cores.
> > >
> > > Yes.
> > >
> > > The assumption with any of these sorts of races is that it is "as
> > > if" the other thread has already passed the location of the write
> > > within that block.  But by the time this thread has finished
> > > do_tb_phys_invalidate, any other thread cannot execute the same
> > > block *again*.
> > >
> > > There's a race here, and now that I think about it, there's been mail about it in the past:
> > >
> > > https://lore.kernel.org/qemu-devel/cebad06c-48f2-6dbd-6d7f-3a3cf5aebbe3@linaro.org/
> > >
> > > We take care of the same race for user-only in translator_access, by
> > > ensuring that each translated page is read-only *before* performing
> > > the read for translation.  But for system mode we grab the page
> > > locks *after* the reads.  Which means there's a race.
> > >
> > > The email above describes the race pretty clearly, with a new TB
> > > being generated before the write is even complete.
> > >
> > > It'll be non-trivial fixing this, because not only do we need to
> > > grab the lock earlier, there are ordering issues for a TB that spans
> > > two pages, in that one must grab the two locks in the correct order
> > > lest we deadlock.
> >
> > Yes I can see how this is hard to fix.  Even if we just lock the page
> > containing the first instruction (which we know) before doing
> > translation, we still have a problem when entering tb_link_page()
> > where we would need to only lock the second page, which might cause
> > ordering issues.
> >
> > How about a new per-page lock, which would be grabbed by
> > do_tb_phys_invalidate() and tb_gen_code(), just on the first
> > instruction?  It would mean, I think, that no page can be having TBs
> > invalidated and generated at the same time.
> >
> > Or something like scanning the bytes as they are being translated,
> > generate a secure-ish checksum, then recheck it after translation and
> > discard the TB if the code changed.
> 
> Hey all,
>   So I've occasionally tripped over something similar in my stress
> testing of the proxy-execution patch series.
> 
> This is only triggered by booting w/ qemu (7.2.2) without kvm. It's
> rare but seems to trip in bursts.
> 
> The errors usually look something like:
> 
> [   21.264283] clocksource: Switched to clocksource hpet
> [   21.273213] hrtimer: interrupt took 2400410 ns
> [   21.369331] VFS: Disk quotas dquot_6.6.0
> [   21.375425] int3: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> [   21.375453] CPU: 12 PID: 0 Comm: swapper/12 Not tainted
> 6.4.0-rc5-00032-g8d3f70560882-dirty #1712
> [   21.375453] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   21.375453] RIP: 0010:hrtimer_start_range_ns+0x1ab/0x3d0
> [   21.375453] Code: 0f 85 70 ff ff ff 44 8b 7c 24 18 4c 63 65 08 4c
> 89 f3 e8 c8 86 0c 01 89 c0 41 83 e7 02 48 03 1c c5 40 0c ac b1 48 89
> 1c 24 0f <1f> 44 00 00 45 85 ff 0f 84 e3 01 00 00 4d 8d 7c 24 01 49 c1
> e4 07
> [   21.375453] RSP: 0018:ffffbf4b000f7e60 EFLAGS: 00000086
> [   21.375453] RAX: 000000000000000c RBX: ffff984ff85239c0 RCX: 00000004ef14ffc0
> [   21.375453] RDX: 7fffffffffffffff RSI: ffffffffb1973381 RDI: ffffffffb1976d48
> [   21.375453] RBP: ffff984ff8523a40 R08: 0000000000000001 R09: 0000000000000000
> [   21.375453] R10: 00000000e8003900 R11: 0000000005673366 R12: 0000000000000000
> [   21.375453] R13: ffff984ff85242f0 R14: 00000000000239c0 R15: 0000000000000002
> [   21.375453] FS:  0000000000000000(0000) GS:ffff984ff8500000(0000)
> knlGS:0000000000000000
> [   21.375453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   21.375453] CR2: 0000000000000000 CR3: 0000000045e62000 CR4: 00000000000006e0
> [   21.375453] Call Trace:
> [   21.375453]  <TASK>
> [   21.375453]  ? die+0x2d/0x80
> [   21.375453]  ? exc_int3+0xf3/0x100
> [   21.375453]  ? asm_exc_int3+0x35/0x40
> [   21.375453]  ? hrtimer_start_range_ns+0x1ab/0x3d0
> [   21.375453]  ? hrtimer_start_range_ns+0x1ab/0x3d0
> [   21.375453]  tick_nohz_restart+0x72/0x90
> [   21.375453]  tick_nohz_idle_exit+0xc7/0xf0
> [   21.375453]  do_idle+0x160/0x220
> [   21.375453]  cpu_startup_entry+0x14/0x20
> [   21.375453]  start_secondary+0xf5/0x100
> [   21.375453]  secondary_startup_64_no_verify+0x10b/0x10b
> [   21.375453]  </TASK>
> 
> 
> Curious if anyone has found a workaround?

Yes, it should be fixed upstream.  You will need these two commits:

commit deba78709ae8ce103e2248413857747f804cd1ef
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Thu Jul 6 17:55:48 2023 +0100

    accel/tcg: Always lock pages before translation

commit cb62bd15e14e304617d250158b77d0deb032f032
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Thu Jul 6 08:45:13 2023 +0100

    accel/tcg: Split out cpu_exec_longjmp_cleanup

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

