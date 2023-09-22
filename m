Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE96F7AAE35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjIVJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjIVJfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F8CDF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695375267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eKVVzoMyaIS+I/BoCTcUvkLZglwzwV/4NWBXdMlWvI=;
        b=BjttIXER4tTyECqCSjfP//NipqBlDBYAhRdB03HpyPaaL7NTjDQBn48DlZT65wyfKhS30d
        PySMiiHjeUC13/YC9E216yQc+4qI6B/0XPlhkrxvorEvE3dcqI4Azg+9cc32TMXJSjJvi9
        6Caye8R4o0ZIHnjO0VeJdPu+1sC8i2U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-KPe3y8APMUGVKE791TwJMw-1; Fri, 22 Sep 2023 05:34:26 -0400
X-MC-Unique: KPe3y8APMUGVKE791TwJMw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-274d62ab09bso1681520a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375264; x=1695980064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eKVVzoMyaIS+I/BoCTcUvkLZglwzwV/4NWBXdMlWvI=;
        b=wN/aoQmXtX7/ftHmMIdef9pFjD3qvUcf8IixncYxdufec96dQwn/5JglLa2bkoxSIp
         oJDT6KJC/WGxUEjJycbnDSwYN17DMRzFk74qPrubvdogfP1+A3cY/4EELkyGc5aGPmp+
         nGwnKDqwWdufSdKFoUNn3GHPcnBLfYrCyiMOcGP5mx3G8V0h8T3iljMg9Khy296eGHyr
         4DghDmNMoY4aq6cdTTRNbmjVRejJII72bLXG3j2YxsPBkZU1bsqJdK3f7iD3+0J66p75
         kt0bMLj/GU8EpIs1VW0ZLTgHOUXldksc5+izOOmmaoUAulBHEOZiFf73rMB8hktK9QIF
         KQsw==
X-Gm-Message-State: AOJu0YxcLjl480IrPUrqYOtJ2xg30bUhTcavnuw8QR2S161w+BkAjmck
        EwQTcA6YXG29rAR9kK+cYr3JYbWYFYAFXGq2ASbI7zW1c0xzNF8H+pjZAQEBO9vLQrPywr2qwo9
        mgPWa8OTwuQAdEMopByaBCpcFvwoue9PA/MF7k8mHkqEyoazvhydX+w==
X-Received: by 2002:a17:90b:3ecd:b0:274:638d:da9a with SMTP id rm13-20020a17090b3ecd00b00274638dda9amr7794393pjb.34.1695375264620;
        Fri, 22 Sep 2023 02:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK4DBbLDDLNJZ8UhZeyMbE9gG0J7zd//ytCG8hbyBizu2LO97+xh8DcXH0rfiSp7Fk12ryttYQhtd0lWkSzCQ=
X-Received: by 2002:a17:90b:3ecd:b0:274:638d:da9a with SMTP id
 rm13-20020a17090b3ecd00b00274638dda9amr7794381pjb.34.1695375264291; Fri, 22
 Sep 2023 02:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+Vt6idZtxfU9jF=VSbu145Wi-d-WnAZx_hEfOL8yLZgBA@mail.gmail.com>
 <ZQ1V8rcSdKg_Jfgh@debian.me>
In-Reply-To: <ZQ1V8rcSdKg_Jfgh@debian.me>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Fri, 22 Sep 2023 17:34:13 +0800
Message-ID: <CAGVVp+V1hDuaMi7Zi2rSjkGyY3Pdo2u78AGtMbuNvg89johnhA@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:throtl_trim_slice+0xc6/0x320 caused kernel panic
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Devices <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 4:53=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Fri, Sep 22, 2023 at 10:10:45AM +0800, Changhui Zhong wrote:
> > Hello,
> >
> > triggered below issue with branch 'for-next',please help check,
> >
> > INFO: HEAD of cloned kernel:
> > commit d975b468819a142a49c8e7db83feb07c3018c550
> > Merge: 58fac6aac7a2 df137dff93fc
> > Author: Jens Axboe <axboe@kernel.dk>
> > Date:   Wed Sep 13 13:16:19 2023 -0600
> >
> >     Merge branch 'io_uring-futex' into for-next
> >
> >     * io_uring-futex:
> >       io_uring: add support for vectored futex waits
> >       futex: make the vectored futex operations available
> >       futex: make futex_parse_waitv() available as a helper
> >       futex: add wake_data to struct futex_q
> >       io_uring: add support for futex wake and wait
> >       futex: abstract out a __futex_wake_mark() helper
> >       futex: factor out the futex wake handling
> >       futex: move FUTEX2_VALID_MASK to futex.h
> >       futex: Validate futex value against futex size
> >       futex: Flag conversion
> >       futex: Extend the FUTEX2 flags
> >       futex: Clarify FUTEX2 flags
> >
> >
> > reproduce steps:
> > echo "+cpuset +cpu +io" > /sys/fs/cgroup/cgroup.subtree_control
> > mkdir /sys/fs/cgroup/test
> > MAJ=3D$(ls -l /dev/"$disk" | awk -F ',' '{print $1}' | awk -F ' ' '{pri=
nt $NF}')
> > MIN=3D$(ls -l /dev/"$disk" | awk -F ',' '{print $2}' | awk -F ' ' '{pri=
nt $1}')
> > echo "$MAJ:$MIN wbps=3D1024" > /sys/fs/cgroup/test/io.max
> > echo $$ > /sys/fs/cgroup/test/cgroup.procs
> > dd if=3D/dev/zero of=3D/dev/$disk bs=3D10k count=3D1 oflag=3Ddirect &
> > dd if=3D/dev/zero of=3D/dev/$disk bs=3D10k count=3D1 oflag=3Ddirect &
> > wait
> >
> > console log:
> > [ 1979.303330] divide error: 0000 [#1] PREEMPT SMP NOPTI
> > [ 1979.308393] CPU: 28 PID: 0 Comm: swapper/28 Not tainted 6.6.0-rc1+ #=
1
> > [ 1979.314837] Hardware name: Dell Inc. PowerEdge R7525/0590KW, BIOS
> > 2.6.6 01/13/2022
> > [ 1979.322402] RIP: 0010:throtl_trim_slice+0xc6/0x320
> > [ 1979.327195] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> > f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> > 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> > ff ff
> > [ 1979.345942] RSP: 0018:ffffadf9c2484dc0 EFLAGS: 00010847
> > [ 1979.351169] RAX: ffffffffffffd8f0 RBX: ffff8f5486a99800 RCX: 0000000=
0000003e8
> > [ 1979.358300] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f5=
486a99800
> > [ 1979.365435] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f5=
65a67b818
> > [ 1979.372565] R10: ffff8f5486a99810 R11: ffff8f565a67b830 R12: 0000000=
000000001
> > [ 1979.379698] R13: ffff8f5486a99808 R14: 0000000000000001 R15: 0000000=
000000021
> > [ 1979.386833] FS:  0000000000000000(0000) GS:ffff8f5677d00000(0000)
> > knlGS:0000000000000000
> > [ 1979.394916] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1979.400663] CR2: 00007f7db5443250 CR3: 0000000459420000 CR4: 0000000=
000350ee0
> > [ 1979.407797] Call Trace:
> > [ 1979.410250]  <IRQ>
> > [ 1979.412270]  ? die+0x33/0x90
> > [ 1979.415157]  ? do_trap+0xe0/0x110
> > [ 1979.418476]  ? throtl_trim_slice+0xc6/0x320
> > [ 1979.422662]  ? do_error_trap+0x65/0x80
> > [ 1979.426412]  ? throtl_trim_slice+0xc6/0x320
> > [ 1979.430600]  ? exc_divide_error+0x36/0x50
> > [ 1979.434612]  ? throtl_trim_slice+0xc6/0x320
> > [ 1979.438800]  ? asm_exc_divide_error+0x16/0x20
> > [ 1979.443163]  ? throtl_trim_slice+0xc6/0x320
> > [ 1979.447347]  tg_dispatch_one_bio+0xf0/0x1e0
> > [ 1979.451533]  throtl_pending_timer_fn+0x1e5/0x510
> > [ 1979.456152]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> > [ 1979.461287]  ? __pfx_throtl_pending_timer_fn+0x10/0x10
> > [ 1979.466427]  call_timer_fn+0x27/0x130
> > [ 1979.470096]  __run_timers.part.0+0x1ee/0x280
> > [ 1979.474368]  ? srso_return_thunk+0x5/0x10
> > [ 1979.478379]  ? __hrtimer_run_queues+0x121/0x2b0
> > [ 1979.482914]  ? srso_return_thunk+0x5/0x10
> > [ 1979.486925]  ? srso_return_thunk+0x5/0x10
> > [ 1979.490939]  ? srso_return_thunk+0x5/0x10
> > [ 1979.494953]  run_timer_softirq+0x26/0x50
> > [ 1979.498878]  __do_softirq+0xcb/0x2ab
> > [ 1979.502459]  __irq_exit_rcu+0xa1/0xc0
> > [ 1979.506124]  sysvec_apic_timer_interrupt+0x72/0x90
> > [ 1979.510917]  </IRQ>
> > [ 1979.513021]  <TASK>
> > [ 1979.515128]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [ 1979.520265] RIP: 0010:mwait_idle+0x4f/0x70
> > [ 1979.524365] Code: 31 d2 48 89 d1 65 48 8b 04 25 80 18 03 00 0f 01
> > c8 48 8b 00 a8 08 75 13 eb 07 0f 00 2d 96 f3 36 00 31 c0 48 89 c1 fb
> > 0f 01 c9 <fa> 65 48 8b 04 25 80 18 03 00 f0 80 60 02 df e9 6d 3f 01 00
> > 0f ae
> > [ 1979.543111] RSP: 0018:ffffadf9c04a7ed0 EFLAGS: 00000246
> > [ 1979.548338] RAX: 0000000000000000 RBX: ffff8f548019cd40 RCX: 0000000=
000000000
> > [ 1979.555471] RDX: 0000000000000000 RSI: 0000000000000087 RDI: 0000000=
00016e484
> > [ 1979.562605] RBP: 0000000000000000 R08: ffff8f5677d22a80 R09: 0000000=
000000000
> > [ 1979.569738] R10: 00000000000001dc R11: 0000000000000000 R12: 0000000=
000000000
> > [ 1979.576868] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
> > [ 1979.584009]  default_idle_call+0x28/0xd0
> > [ 1979.587938]  cpuidle_idle_call+0x125/0x160
> > [ 1979.592036]  ? sched_clock_cpu+0xb/0x190
> > [ 1979.595963]  do_idle+0x7b/0xe0
> > [ 1979.599022]  cpu_startup_entry+0x19/0x20
> > [ 1979.602949]  start_secondary+0x115/0x140
> > [ 1979.606875]  secondary_startup_64_no_verify+0x17d/0x18b
> > [ 1979.612104]  </TASK>
> > [ 1979.614293] Modules linked in: binfmt_misc dm_crypt raid10 raid1
> > raid0 dm_raid raid456 async_raid6_recov async_memcpy async_pq
> > async_xor xor async_tx raid6_pq loop tls rpcsec_gss_krb5 auth_rpcgss
> > nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill sunrpc
> > dm_multipath ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac
> > edac_mce_amd kvm_amd kvm mgag200 i2c_algo_bit dcdbas acpi_ipmi
> > drm_shmem_helper irqbypass ipmi_si drm_kms_helper dell_smbios rapl
> > wmi_bmof pcspkr dell_wmi_descriptor ipmi_devintf k10temp ptdma
> > i2c_piix4 ipmi_msghandler acpi_power_meter drm fuse xfs libcrc32c
> > sd_mod t10_pi sg ahci libahci crct10dif_pclmul crc32_pclmul
> > crc32c_intel libata ghash_clmulni_intel tg3 ccp sp5100_tco wmi
> > dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
> > [ 1979.681931] ---[ end trace 0000000000000000 ]---
> > [ 1979.706620] pstore: backend (erst) writing error (-22)
> > [ 1979.711761] RIP: 0010:throtl_trim_slice+0xc6/0x320
> > [ 1979.716555] Code: 00 00 48 89 e8 48 f7 f1 48 29 d5 74 9f 40 0f b6
> > f6 48 89 df 89 34 24 e8 f8 f5 ff ff 8b 34 24 b9 e8 03 00 00 48 89 df
> > 48 f7 e5 <48> f7 f1 49 03 85 f8 01 00 00 49 89 c7 e8 78 e0 ff ff ba ff
> > ff ff
> > [ 1979.735301] RSP: 0018:ffffadf9c2484dc0 EFLAGS: 00010847
> > [ 1979.740527] RAX: ffffffffffffd8f0 RBX: ffff8f5486a99800 RCX: 0000000=
0000003e8
> > [ 1979.747659] RDX: 000000000000270f RSI: 0000000000000001 RDI: ffff8f5=
486a99800
> > [ 1979.754793] RBP: 0000000000002710 R08: ffffffffffffffff R09: ffff8f5=
65a67b818
> > [ 1979.761924] R10: ffff8f5486a99810 R11: ffff8f565a67b830 R12: 0000000=
000000001
> > [ 1979.769056] R13: ffff8f5486a99808 R14: 0000000000000001 R15: 0000000=
000000021
> > [ 1979.776190] FS:  0000000000000000(0000) GS:ffff8f5677d00000(0000)
> > knlGS:0000000000000000
> > [ 1979.784278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1979.790023] CR2: 00007f7db5443250 CR3: 0000000459420000 CR4: 0000000=
000350ee0
> > [ 1979.797155] Kernel panic - not syncing: Fatal exception in interrupt
> > [ 1979.805797] Kernel Offset: 0x30600000 from 0xffffffff81000000
> > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > [ 1979.835382] ---[ end Kernel panic - not syncing: Fatal exception in
> > interrupt ]---
> >
>
> Does v6.6-rc2 have this issue? v6.5?
>
> --


 I not test v6.5=EF=BC=8CI only tested branch =E2=80=9Cfor-next=E2=80=9D / =
=E2=80=9Cblock-6.6=E2=80=9D
recent=EF=BC=8Cand both branches have this issue=EF=BC=8C
 I will try again with v6.6-rc2=EF=BC=8C

 Thanks=EF=BC=8C

