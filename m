Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD37EB51F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjKNQtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKNQtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:49:13 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88711D;
        Tue, 14 Nov 2023 08:49:08 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so77543241fa.3;
        Tue, 14 Nov 2023 08:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699980546; x=1700585346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aVAws9YeIyFR+hesFeFPCooRUdKSeV231BWF7s3vIQ=;
        b=gVnHjBZDC5lUbpl8fAFcxG8FYaK/PAn3SSqLLmzwr9oUSZVrIzjwVo9+8mIm19NaPh
         AGy3n5huv6kcG+dZkLRVkhLMxgl4sbA13TyKK4/hVoYP9FGNO9KU7sdsx0DjF4iNdcdK
         m6GM4eax487ALMHHxbD+xstwAa64lHSt16O6R76QYZpKIM/xsMTaRlonjaAendQtjbW5
         qC3neaWH/5eQaNRSPTJtvU9105fvlZz6bYygEesPkyKeJyj7ZCHZw0Izfex+A2Lof3x0
         tEjQ1hvNzrLRXeuoeGyo7EO9k0G+4WtWDy1BSis7Ti818LzHqShfz5Pv+lca3uTShmLm
         +CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699980546; x=1700585346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aVAws9YeIyFR+hesFeFPCooRUdKSeV231BWF7s3vIQ=;
        b=pkZ+YeMFutWTgl0Jpi+CbPhMPQ9XjZOLas9deFUUc2MsI1ysCormW/WDG+FtJ5EeMd
         AX8fCY3QPFYtrjo+wxAJ3PYndwH5oMRxqSrTGNma1dBVXA2XRFd0Xe2JN5eg6oXWMFDO
         4Nze/i7UeXTrP07XG3HiPuRu5T02/6wkXJge8Dlx3jMpWCE4pPpuCAizycPAgm4bfg1x
         vI5wyfph1MWWGP9GPfb9gj9x7ETiIKPGqK0A81bTBhtUfuySfyr6GdMFewmTLMCrwLXI
         7MFwoGxRtZvUgERwnxdlEl29KQViQuWuN4huFoSnb+6LZ15FVhCcfgXyk+pbYPcrLh4m
         iYqA==
X-Gm-Message-State: AOJu0YydoPUmvX6xnBj4+wxH8Jgip0J7OGQ/K/UCu7oo1llJgI/dg0V8
        MHa7DNS7JM9OWqE0y8Nog7RAbZwi1yjhITeRqvY=
X-Google-Smtp-Source: AGHT+IFpPuFf1jwY+DeVcfirQ8pK3F/Gu95MZ+i61QF3po1nZDAYKa/XPta0y0MXq+OuWwB+Q4uxz8svSVo1/FcQ2z4=
X-Received: by 2002:a05:651c:1316:b0:2c7:2e27:5b46 with SMTP id
 u22-20020a05651c131600b002c72e275b46mr1901024lja.37.1699980546196; Tue, 14
 Nov 2023 08:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20231112150030.84609-1-ryncsn@gmail.com> <ZVKgcuCf_FbtaZrW@FVFF77S0Q05N>
In-Reply-To: <ZVKgcuCf_FbtaZrW@FVFF77S0Q05N>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Wed, 15 Nov 2023 00:48:48 +0800
Message-ID: <CAMgjq7BW79KDSCyp+tZHjShSzHsScSiJxn5ffskp-QzVM06fxw@mail.gmail.com>
Subject: Re: [PATCH] tracing: fix UAF caused by memory ordering issue
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C 06:17=E5=86=99=E9=81=93=EF=BC=9A
>

Hi, Mark and Steven

Thank you so much for the detailed comments.

> On Sun, Nov 12, 2023 at 11:00:30PM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Following kernel panic was observed when doing ftrace stress test:
>
> Can you share some more details:
>
> * What test specifically are you running? Can you share this so that othe=
rs can
>   try to reproduce the issue?

Yes, the panic happened when doing LTP ftrace stress test:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/trac=
ing/ftrace_test/ftrace_stress_test.sh

>
> * Which machines are you testing on (i.e. which CPU microarchitecture is =
this
>   seen with) ?

The panic was seen on a ARM64 VM, lscpu output:
Architecture:           aarch64
  CPU op-mode(s):       64-bit
  Byte Order:           Little Endian
CPU(s):                 4
  On-line CPU(s) list:  0-3
Vendor ID:              HiSilicon
  BIOS Vendor ID:       QEMU
  Model name:           Kunpeng-920
    BIOS Model name:    virt-rhel8.6.0  CPU @ 2.0GHz
    BIOS CPU family:    1
    Model:              0
    Thread(s) per core: 1
    Core(s) per socket: 1
    Socket(s):          4
    Stepping:           0x1
    BogoMIPS:           200.00
    Flags:              fp asimd evtstrm aes pmull sha1 sha2 crc32
atomics fphp asimdhp cpuid asimdrdm jscvt fcma dcpop asimddp asimdfhm

The host machine is a Kunpeng-920 with 4 NUMA nodes and 128 cores.

>
> * Which compiler are you using?

gcc 12.3.1

>
> * The log shows this is with v6.1.61+. Can you reproduce this with a main=
line
>   kernel? e.g. v6.6 or v6.7-rc1?

It's reproducible with LTS, not tested with mainline, I'll try to
reproduce this with the latest mainline. But due to the low
reproducibility this may take a while.

>
> > Unable to handle kernel paging request at virtual address 9699b0f8ece28=
240
> > Mem abort info:
> >   ESR =3D 0x0000000096000004
> >   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >   SET =3D 0, FnV =3D 0
> >   EA =3D 0, S1PTW =3D 0
> >   FSC =3D 0x04: level 0 translation fault
> > Data abort info:
> >   ISV =3D 0, ISS =3D 0x00000004
> >   CM =3D 0, WnR =3D 0
> > [9699b0f8ece28240] address between user and kernel address ranges
> > Internal error: Oops: 0000000096000004 [#1] SMP
> > Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core rfkill vfat fat =
loop fuse nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables ext4 mbcach=
e jbd2 sr_mod cdrom crct10dif_ce ghash_ce sha2_ce virtio_gpu virtio_dma_buf=
 drm_shmem_helper virtio_blk drm_kms_helper syscopyarea sysfillrect sysimgb=
lt fb_sys_fops virtio_console sha256_arm64 sha1_ce drm virtio_scsi i2c_core=
 virtio_net net_failover failover virtio_mmio dm_multipath dm_mod autofs4 [=
last unloaded: ipmi_msghandler]
> > CPU: 0 PID: 499719 Comm: sh Kdump: loaded Not tainted 6.1.61+ #2
> > Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> > pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : __kmem_cache_alloc_node+0x1dc/0x2e4
> > lr : __kmem_cache_alloc_node+0xac/0x2e4
> > sp : ffff80000ad23aa0
> > x29: ffff80000ad23ab0 x28: 00000004052b8000 x27: ffffc513863b0000
> > x26: 0000000000000040 x25: ffffc51384f21ca4 x24: 00000000ffffffff
> > x23: d615521430b1b1a5 x22: ffffc51386044770 x21: 0000000000000000
> > x20: 0000000000000cc0 x19: ffff0000c0001200 x18: 0000000000000000
> > x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaae65e1630
> > x14: 0000000000000004 x13: ffffc513863e67a0 x12: ffffc513863af6d8
> > x11: 0000000000000001 x10: ffff80000ad23aa0 x9 : ffffc51385058078
> > x8 : 0000000000000018 x7 : 0000000000000001 x6 : 0000000000000010
> > x5 : ffff0000c09c2280 x4 : ffffc51384f21ca4 x3 : 0000000000000040
> > x2 : 9699b0f8ece28240 x1 : ffff0000c09c2280 x0 : 9699b0f8ece28200
> > Call trace:
> >  __kmem_cache_alloc_node+0x1dc/0x2e4
> >  __kmalloc+0x6c/0x1c0
> >  func_add+0x1a4/0x200
> >  tracepoint_add_func+0x70/0x230
> >  tracepoint_probe_register+0x6c/0xb4
> >  trace_event_reg+0x8c/0xa0
> >  __ftrace_event_enable_disable+0x17c/0x440
> >  __ftrace_set_clr_event_nolock+0xe0/0x150
> >  system_enable_write+0xe0/0x114
> >  vfs_write+0xd0/0x2dc
> >  ksys_write+0x78/0x110
> >  __arm64_sys_write+0x24/0x30
> >  invoke_syscall.constprop.0+0x58/0xf0
> >  el0_svc_common.constprop.0+0x54/0x160
> >  do_el0_svc+0x2c/0x60
> >  el0_svc+0x40/0x1ac
> >  el0t_64_sync_handler+0xf4/0x120
> >  el0t_64_sync+0x19c/0x1a0
> > Code: b9402a63 f9405e77 8b030002 d5384101 (f8636803)
> >
> > Panic was caused by corrupted freelist pointer. After more debugging,
> > I found the root cause is UAF of slab allocated object in ftrace
> > introduced by commit eecb91b9f98d ("tracing: Fix memleak due to race
> > between current_tracer and trace"), and so far it's only reproducible
> > on some ARM64 machines, the UAF and free stack is:
> >
> > UAF:
> > kasan_report+0xa8/0x1bc
> > __asan_report_load8_noabort+0x28/0x3c
> > print_graph_function_flags+0x524/0x5a0
> > print_graph_function_event+0x28/0x40
> > print_trace_line+0x5c4/0x1030
> > s_show+0xf0/0x460
> > seq_read_iter+0x930/0xf5c
> > seq_read+0x130/0x1d0
> > vfs_read+0x288/0x840
> > ksys_read+0x130/0x270
> > __arm64_sys_read+0x78/0xac
> > invoke_syscall.constprop.0+0x90/0x224
> > do_el0_svc+0x118/0x3dc
> > el0_svc+0x54/0x120
> > el0t_64_sync_handler+0xf4/0x120
> > el0t_64_sync+0x19c/0x1a0
> >
> > Freed by:
> > kasan_save_free_info+0x38/0x5c
> > __kasan_slab_free+0xe8/0x154
> > slab_free_freelist_hook+0xfc/0x1e0
> > __kmem_cache_free+0x138/0x260
> > kfree+0xd0/0x1d0
> > graph_trace_close+0x60/0x90
> > s_start+0x610/0x910
> > seq_read_iter+0x274/0xf5c
> > seq_read+0x130/0x1d0
> > vfs_read+0x288/0x840
> > ksys_read+0x130/0x270
> > __arm64_sys_read+0x78/0xac
> > invoke_syscall.constprop.0+0x90/0x224
> > do_el0_svc+0x118/0x3dc
> > el0_svc+0x54/0x120
> > el0t_64_sync_handler+0xf4/0x120
> > el0t_64_sync+0x19c/0x1a0
> >
> > Despite the s_start and s_show being serialized by seq_file mutex,
> > the tracer struct copy in s_start introduced by the commit mentioned
> > above is not atomic nor guarenteened to be seen by all CPUs. So
> > following seneriao is possible (and actually happened):
> >
> > CPU 1                                     CPU 2
> > seq_read_iter                             seq_read_iter
> >   mutex_lock(&m->lock);
> >   s_start
> >     // iter->trace is graph_trace
> >     iter->trace->close(iter);
> >     graph_trace_close
> >       kfree(data) <- *** data released here ***
> >     // copy current_trace to iter->trace
> >     // but not synced to CPU 2
> >     *iter->trace =3D *tr->current_trace
> >   ... (goes on)
> >   mutex_unlock(&m->lock);
> >                                           mutex_lock(&m->lock);
> >                                           ... (s_start and other work)
> >                                           s_show
> >                                             print_trace_line(iter)
> >                                               // iter->trace is still
> >                                               // old value (graph_trace=
)
>
> As Steve pointed out in his reply, the mutex should ensure that CPU 2 obs=
erves
> the stores from CPU 1, regardless of whether those were atomic. If this i=
s
> seeing an old value, then either:
>
> * This description is incorrect. Either we're using the mutex incorrectly=
, or
>   we have accesses which are not protect by the mutex.
>
> * The memory is being corrupted elsewhere.
>
>   KCSAN might be able to detect this.
>
> * There is a bug in the mutex implementation, and it's not providing the
>   ordering it should.
>
> * The compiler is reordering memory accesses incorrectly.
>
> * There is a CPU bug.

You are right, after reviewing the code more carefully I also found my
description doesn't make sense indeed...

The original panic was observed every few hours or day when running
LTP ftrace stress test on the ARM64 VM mentioned above, and the panic
is gone after revert commit eecb91b9f98d (in 6.1 LTS).
Since it's not reproducible on x86_64, but stably reproducible on
ARM64 (with KASAN and many other DEBUG options on or not), and KASAN
reports the UAF so my first thought is memory ordering issue. The
smp_wmb is compiled into a dmb and the problem is gone (stress test on
dozens of same VM machines for a few days and the panic never happens
again). Now I'm also puzzled about the root cause.

>
> >                                               iter->trace->print_line()
> >                                                 print_graph_function_fl=
ags
> >                                                   data->cpu_data <- ***=
 data UAF ***
> >
> > The UAF corrupted the slab freelist and caused panic on another slab
> > allocation.
> >
> > After applying the barrier, the problem is gone.
> >
> > Fixes: eecb91b9f98d ("tracing: Fix memleak due to race between current_=
tracer and trace")
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  kernel/trace/trace.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 9aebf904ff97..c377cdf3701b 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4182,11 +4182,14 @@ static void *s_start(struct seq_file *m, loff_t=
 *pos)
> >       int cpu;
> >
> >       mutex_lock(&trace_types_lock);
> > -     if (unlikely(tr->current_trace !=3D iter->trace)) {
> > -             /* Close iter->trace before switching to the new current =
tracer */
> > -             if (iter->trace->close)
> > -                     iter->trace->close(iter);
> > -             iter->trace =3D tr->current_trace;
> > +     if (unlikely(tr->current_trace && iter->trace->name !=3D tr->curr=
ent_trace->name)) {
> > +             /* Switch to the new current tracer then close old tracer=
 */
> > +             struct tracer *prev_trace =3D iter->trace;
> > +             *iter->trace =3D *tr->current_trace;
> > +             /* Make sure the switch is seen by all CPUs before closin=
g */
> > +             smp_wmb();
>
> As Steven said, I don't think that this barrier makes sense. It shouldn't=
 be
> necessary given the mutex, and it's not pairing with a reader.

Right, I just forgot the fact of mutex having barriers and made a
wrong assumption here.

> Some of the possibilities I mentioned above would be masked by this (e.g.=
 lack
> of mutex release ordering). If you could answer my questions at the start=
 of
> this mail, it would help to narrow this down.

Yes, there could be some hidden root cause, the previous full KASAN log is =
here:
https://gist.github.com/ryncsn/3f1509eb3a359d7cefda76942b36249c

I'll try to do more debugging to figure it out.
