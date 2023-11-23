Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395247F62C3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbjKWP07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346084AbjKWP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE49D66
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700753216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pe3U116kfqunsSSVD3+8u5zgquNIc0fr2DO0KLfE54Y=;
        b=Up30EPfmyR+uHXklSqnRhHzzsMVLFNQKEoTBwS6WBThWHRYA5uhuSW1ClkhPfPz7LGtZIk
        K7uXDrFytyMkMr4Tiahc+K1cFxThx7TfDfL2zESptdKA0YhgwbdfgjMqWdDeBcTckd2s80
        sk/9uZ3b0qZaMoxvGNA1uJozSPyp3Ds=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-bhjL2VzFPHWXCwaQ-aYgtg-1; Thu, 23 Nov 2023 10:26:54 -0500
X-MC-Unique: bhjL2VzFPHWXCwaQ-aYgtg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a00dd93a5f9so65076766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700753213; x=1701358013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe3U116kfqunsSSVD3+8u5zgquNIc0fr2DO0KLfE54Y=;
        b=RN2K9wV14r1Bxd2q0vYm9KZO4Okwg6Gx50HCKpsCGaVheRGPhZDY2NGH5r08vZrO3I
         VAyVuX9KMNU9xIcCm2A4g6FjfyYbPHl7y3Mpj2iKLjQFatNQXM+gSvEDI5CHVBsVL3O7
         ZYQR+DlzWzwWLDmWGO9HJZZOA0Cci0iauZ053dBRt6M9AI+2V9pX2/sw7wIRSl4V68ln
         wm9P0wcIgEYiU0cl7hLYntYby0szQvEqpYSkMFGMrxdoJNd4gmnz4doJpnpA/azxis3r
         B18mAppgT6rdi9U3tZ3ijNT/VHKbby6xFvy3HcnOGJM2F246QxhpvMBRMNCJvwmaiXFu
         1FWA==
X-Gm-Message-State: AOJu0Yxy7Ti9AqmxjirPHaiVUz9GvcNyxfEbwn+3JNDuziKyFWNV6VNh
        /nK9iEcrzNK0YYjc+CU0SsQ5Nr4wv5fRYH9f/LfIMSksVY32NCBrVzB4Qj8t9z5ivQQgA8C20Z9
        ntOd7OQ5BDAbta0OXFQN3SFYb6v8QDMTr46fPerki
X-Received: by 2002:a17:906:4c5a:b0:9be:562:a44a with SMTP id d26-20020a1709064c5a00b009be0562a44amr4025707ejw.23.1700753213749;
        Thu, 23 Nov 2023 07:26:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESWkeUpthJ4n6g6LPyHSwfiRnVe6XhFNJTC8y16GEyQ/V3bVT/zbkm84BuwBFLEENZ6gD1GmtY+S2S//H+LXU=
X-Received: by 2002:a17:906:4c5a:b0:9be:562:a44a with SMTP id
 d26-20020a1709064c5a00b009be0562a44amr4025695ejw.23.1700753213479; Thu, 23
 Nov 2023 07:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20231115210509.481514-3-vschneid@redhat.com> <202311202323.8c66ae1c-oliver.sang@intel.com>
In-Reply-To: <202311202323.8c66ae1c-oliver.sang@intel.com>
From:   Valentin Schneider <vschneid@redhat.com>
Date:   Thu, 23 Nov 2023 16:26:41 +0100
Message-ID: <CAD235PTGhmZNOiS5U1_4tCzjiZY9vp89gmSOLwR7JSnjF9ZUkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tcp/dcpp: Don't disable bh around timewait_sock initialization
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, dccp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 at 16:24, kernel test robot <oliver.sang@intel.com> wro=
te:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:inconsistent_lock_state" on:
>
> commit: 0258784e371906dfa1419556dcb7905333039f34 ("[PATCH v2 2/2] tcp/dcp=
p: Don't disable bh around timewait_sock initialization")
> url: https://github.com/intel-lab-lkp/linux/commits/Valentin-Schneider/tc=
p-dcpp-Un-pin-tw_timer/20231116-053100
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 674e3180=
89468ece99aef4796eaef7add57f36b2
> patch link: https://lore.kernel.org/all/20231115210509.481514-3-vschneid@=
redhat.com/
> patch subject: [PATCH v2 2/2] tcp/dcpp: Don't disable bh around timewait_=
sock initialization
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202311202323.8c66ae1c-oliver.san=
g@intel.com
>
>
>
> [   53.969777][    C0]
> [   53.970087][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   53.970532][    C0] WARNING: inconsistent lock state
> [   53.970976][    C0] 6.6.0-15915-g0258784e3719 #1 Tainted: G        W  =
      N
> [   53.971566][    C0] --------------------------------
> [   53.972004][    C0] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usag=
e.
> [   53.972562][    C0] kallsyms_test/97 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [ 53.973095][ C0] ffffc90000281348 (&tcp_hashinfo.bhash[i].lock){+.?.}-{2=
:2}, at: inet_twsk_hashdance (include/linux/spinlock.h:351 net/ipv4/inet_ti=
mewait_sock.c:132)
> [   53.973952][    C0] {SOFTIRQ-ON-W} state was registered at:
> [ 53.974434][ C0] __lock_acquire (kernel/locking/lockdep.c:5090)
> [ 53.974857][ C0] lock_acquire (kernel/locking/lockdep.c:467 kernel/locki=
ng/lockdep.c:5755 kernel/locking/lockdep.c:5718)
> [ 53.975264][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 ke=
rnel/locking/spinlock.c:154)
> [ 53.975673][ C0] inet_twsk_hashdance (include/linux/spinlock.h:351 net/i=
pv4/inet_timewait_sock.c:132)
> [ 53.976122][ C0] tcp_time_wait (include/net/inet_timewait_sock.h:108 net=
/ipv4/tcp_minisocks.c:343)
> [ 53.976533][ C0] tcp_fin (net/ipv4/tcp_input.c:4508)
> [ 53.976911][ C0] tcp_data_queue (net/ipv4/tcp_input.c:5188)
> [ 53.977336][ C0] tcp_rcv_state_process (net/ipv4/tcp_input.c:6850)
> [ 53.977802][ C0] tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929)
> [ 53.978216][ C0] __release_sock (net/core/sock.c:2970)
> [ 53.978634][ C0] __tcp_close (net/ipv4/tcp.c:2847)
> [ 53.979035][ C0] tcp_close (net/ipv4/tcp.c:2922)
> [ 53.979413][ C0] inet_release (net/ipv4/af_inet.c:434)
> [ 53.979817][ C0] __sock_release (net/socket.c:660)
> [ 53.980229][ C0] sock_close (net/socket.c:1421)
> [ 53.980610][ C0] __fput (fs/file_table.c:394)
> [ 53.980986][ C0] task_work_run (kernel/task_work.c:182 (discriminator 1)=
)
> [ 53.981401][ C0] do_exit (kernel/exit.c:872)
> [ 53.981777][ C0] do_group_exit (kernel/exit.c:1002)

> [   53.984034][    C0] irq event stamp: 95812558
> [ 53.984434][ C0] hardirqs last enabled at (95812558): _raw_spin_unlock_i=
rqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags=
.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:=
151 kernel/locking/spinlock.c:194)
> [ 53.985302][ C0] hardirqs last disabled at (95812557): _raw_spin_lock_ir=
qsave (include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162)
> [ 53.986123][ C0] softirqs last enabled at (95812510): __do_softirq (arch=
/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582)
> [ 53.986900][ C0] softirqs last disabled at (95812513): irq_exit_rcu (ker=
nel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:622 kernel/softirq.=
c:644)
> [   53.987664][    C0]
> [   53.987664][    C0] other info that might help us debug this:
> [   53.988335][    C0]  Possible unsafe locking scenario:
> [   53.988335][    C0]
> [   53.988971][    C0]        CPU0
> [   53.989291][    C0]        ----
> [   53.989611][    C0]   lock(&tcp_hashinfo.bhash[i].lock);
> [   53.990076][    C0]   <Interrupt>
> [   53.990404][    C0]     lock(&tcp_hashinfo.bhash[i].lock);
> [   53.990883][    C0]
> [   53.990883][    C0]  *** DEADLOCK ***
> [   53.990883][    C0]
> [   53.991593][    C0] 3 locks held by kallsyms_test/97:
> [ 53.992048][ C0] #0: ffffffff87560480 (rcu_read_lock){....}-{1:2}, at: n=
etif_receive_skb_list_internal (include/linux/rcupdate.h:301 include/linux/=
rcupdate.h:747 net/core/dev.c:5748)
> [ 53.992919][ C0] #1: ffffffff87560480 (rcu_read_lock){....}-{1:2}, at: i=
p_local_deliver_finish+0x1d3/0x410
> [ 53.993815][ C0] #2: ffff88816d626cb0 (slock-AF_INET/1){+.-.}-{2:2}, at:=
 tcp_v4_rcv (include/linux/skbuff.h:1609 include/net/tcp.h:2458 net/ipv4/tc=
p_ipv4.c:2326)

So this looks like we do rely on disabling BH in the hashdance, not
only for the timer but also for the
  spin_lock(&bhead2->lock);
which needs to be softirq-safe.

