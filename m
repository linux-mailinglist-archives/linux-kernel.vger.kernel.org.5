Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA957E5C42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjKHRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjKHRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:18:35 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D7E8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:18:33 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231108171832euoutp01852115f3292c0ff27bcd534d2b23b3ad~VtWyR01Fk2082220822euoutp01P
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 17:18:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231108171832euoutp01852115f3292c0ff27bcd534d2b23b3ad~VtWyR01Fk2082220822euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699463912;
        bh=dGRgmxowVaGGZ4Ol9UNPg/Yvhh+S7zv7IWIf+XEGkYA=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=dIIPphV+pqaB0N4r8Cfn7UoYp+P3rMamnIGCZc0Jijx6kEazrNE/ctFirV/QapMZ+
         hknGaWXMAyJWHXZyzNK8FwgKfmo1ptg45C1C7vWJwJ6j9FQU4XgDtWOZ/ZYWOaVDEz
         8ax39yRs1JVB++/hfPISzOvGKV04xM4gWHZkXHvU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231108171832eucas1p2abd8143c032b2aaf962a13443ca76fe1~VtWyCT2mX0720507205eucas1p2r;
        Wed,  8 Nov 2023 17:18:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 79.A7.42423.7E2CB456; Wed,  8
        Nov 2023 17:18:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231108171831eucas1p1a00ff3226538e05e6e233da504e1cd43~VtWxnonh41210912109eucas1p1N;
        Wed,  8 Nov 2023 17:18:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231108171831eusmtrp28c4ff1bd8519797ac9213237341ab188~VtWxm8YRy1603516035eusmtrp2f;
        Wed,  8 Nov 2023 17:18:31 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-91-654bc2e79fcd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.97.25043.7E2CB456; Wed,  8
        Nov 2023 17:18:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231108171830eusmtip188a7490eebcc861f08d06bb6c033feda~VtWw01mFs3049530495eusmtip1m;
        Wed,  8 Nov 2023 17:18:30 +0000 (GMT)
Message-ID: <4a49e782-465d-434d-b101-8ca478914b72@samsung.com>
Date:   Wed, 8 Nov 2023 18:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] riscv: fix potential panic during CPU hot-plug
To:     Evan Green <evan@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Content-Language: en-US
In-Reply-To: <CALs-Hst6fmesQy6g=ZxfKFs5W85quWQRcwP_=okBWKqMA3CQsw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87rPD3mnGiy9bGlxa5K6xdbfs9gt
        Fp5MtpiyaQe7xZEpdhb/H71mtWg+tp7N4vKuOWwW2z63sFm8vNzDbNE2i9+B2+PNy5csHoc7
        vrB7bFrVyeaxeUm9x50fSxk9bsyK8LjUfJ3dY/u1ecwef39uZfH4vEkugCuKyyYlNSezLLVI
        3y6BK2Pr9b1MBRf0Kg413WRtYHyl3sXIySEhYCJx9foONhBbSGAFo8TNJ8JdjFxA9hdGid4P
        +5ghnM+MErc+vGOC6Xjfc4IVIrGcUeJQ3yQmCOcjo8SK9V/AZvEK2EkcO9MHZrMIqEicW3eH
        GSIuKHFy5hMWEFtUQF7i/q0Z7CA2m4ChRNfbLrB6YQFniWn/WoHqOThEBJQk7r0uBpnPLNDH
        LNH1/BErSA2zgLjErSfzwS7iFAiUeDtxHwtEXF6ieetsZohLZ3NKbFoKZbtI7Jz4HeoDYYlX
        x7ewQ9gyEv93zgd7QEKgnVFiwe/7UM4ERomG57cYIaqsJe6c+8UGchGzgKbE+l36EGFHia7e
        tYwgYQkBPokbbwUhbuCTmLRtOjNEmFeio00IolpNYtbxdXBrD164xDyBUWkWUqjMQvLZLCTf
        zELYu4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgQjv97/inHYxzX33UO8TIxMF4
        iFGCg1lJhPevvUeqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQimCwT
        B6dUA5PbrYtnN15/8rRxU0S4nGSQ5d6twtJBIa8LjvQtvX+SO7jp2CThMxeNfm2L/12Zvviv
        btnKVcXfRAoD5RZ4XpuWUZjmvG333qiwMwv520pXmCo4n37NKSy7WKnD8UbYCt3zP2+0n3LJ
        t7NS93ukyWjv/K9Pxjv1il95aYKlS9i5aXfVlndrfNYyZ72pzhwVIshwzDjxZaFg28d1B7wO
        mVSpzSyta/F1t+XpeHCLf1L5JzkOw5KAt9MOHo3frSK6RmHK0v58hQZBuXPMvXd3FtcllZXO
        NM43btzxSLnkhVrlTJ6ZDw9oPXR2ynogPWVFgdLLm1sFX68z2s3Bc3XXCdHgC65z5p993W3+
        ZK2woRJLcUaioRZzUXEiABV/PUzXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7rPD3mnGjQ9krO4NUndYuvvWewW
        C08mW0zZtIPd4sgUO4v/j16zWjQfW89mcXnXHDaLbZ9b2CxeXu5htmibxe/A7fHm5UsWj8Md
        X9g9Nq3qZPPYvKTe486PpYweN2ZFeFxqvs7usf3aPGaPvz+3snh83iQXwBWlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7H1+l6mggt6FYeabrI2
        ML5S72Lk5JAQMJF433OCtYuRi0NIYCmjRNvP2WwQCRmJk9MaWCFsYYk/17rYIIreM0ocm/2J
        ESTBK2AncexMH1gDi4CKxLl1d5gh4oISJ2c+YQGxRQXkJe7fmsEOYrMJGEp0ve0CqxcWcJaY
        9q8VqJ6DQ0RASeLe62KQ+cwCE5glWg81MUMsu8kocXjHDSaQBmYBcYlbT+aD2ZwCgRJvJ+5j
        gYibSXRt7WKEsOUlmrfOZp7AKDQLyR2zkLTPQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIFRvO3Yzy07GFe++qh3iJGJg/EQowQHs5II7197j1Qh3pTEyqrUovz4otKc1OJD
        jKbAwJjILCWanA9MI3kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxS
        DUxqagmi+qJC2jZM5lr1US+rDr408PC1faJsdH3Gy0kF7IvmanV6L55971jqq3sp/zmPlLgv
        PGVlNG3DKpNlcS/kpkzxEi61PrLsdXfwvgWd+zafNTir+13j3B6O91aTWbo2reLliShbztqz
        OVJ/1wZtBfby+cYB7yeLpkiHOJS15z1xdhBlrPytYjNnb5YOwyW7retlVi96cyvyzj7xtz57
        9Hkkba6b+VuvWRiQYOx/LfBT/MQaAemFYvzLdpjfWPPamq1hz4nLM9xnrmRUjpjE9Cb1eRvn
        484Pm569+d6+enn8BrapC8/0pAY8W/zqyqMd33I/FrHIdDaLaN0UeyNVdLFph9eulz09tZdS
        T5kqsRRnJBpqMRcVJwIA+tAwQmsDAAA=
X-CMS-MailID: 20231108171831eucas1p1a00ff3226538e05e6e233da504e1cd43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3
References: <CGME20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3@eucas1p2.samsung.com>
        <20231108112909.591987-1-m.szyprowski@samsung.com>
        <CALs-Hst6fmesQy6g=ZxfKFs5W85quWQRcwP_=okBWKqMA3CQsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Evan,

On 08.11.2023 17:47, Evan Green wrote:
> On Wed, Nov 8, 2023 at 3:29 AM Marek Szyprowski
> <m.szyprowski@samsung.com>  wrote:
>> Commit 584ea6564bca ("RISC-V: Probe for unaligned access speed") added a
>> test for unaligned access speed. It is being performed when given CPU is
>> onlined. Then, another test for misaligned access emulation has been
>> added in commit 71c54b3d169d ("riscv: report misaligned accesses
>> emulation to hwprobe"). This unaligned access speed doesn't really change
>> after the boot, so it is sufficient to do this test only once. This has
>> been partially added by commit c20d36cc2a20 ("riscv: don't probe
>> unaligned access speed if already done"), but this optimisation works
>> only if RISCV_HWPROBE_MISALIGNED_EMULATED is returned by the latter
>> check. Otherwise the 'misaligned_access_speed' pcpu varliable is
>> overwritten with RISCV_HWPROBE_MISALIGNED_UNKNOWN value, what makes the
>> first check to be always performed.
>>
>> Recently I've noticed that the first check introduced a regression in the
>> CPU hot-plug mechanism. This can be observed as a following panic on
>> QEmu:
>>
>> CPU1: off
>> cpu1: Ratio of byte access time to unaligned word access is 7.00, unaligned accesses are fast
>> CPU1: off
>> CPU1: failed to come online
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 215 at kernel/smp.c:437 __flush_smp_call_function_queue+0x90/0x292
>> Modules linked in:
>> CPU: 0 PID: 215 Comm: bash Not tainted 6.5.0-rc1+ #7524
>> Hardware name: riscv-virtio,qemu (DT)
>> epc : __flush_smp_call_function_queue+0x90/0x292
>>   ra : smpcfd_dying_cpu+0xe/0x1c
>> ...
>> [<ffffffff800c904a>] __flush_smp_call_function_queue+0x90/0x292
>> [<ffffffff800c9ae8>] smpcfd_dying_cpu+0xe/0x1c
>> [<ffffffff80012b2e>] cpuhp_invoke_callback+0x124/0x322
>> [<ffffffff800142f8>] _cpu_up+0x218/0x322
>> [<ffffffff8001445e>] cpu_up+0x5c/0x98
>> [<ffffffff80014bb8>] cpu_device_up+0x14/0x1c
>> [<ffffffff8066d68e>] cpu_subsys_online+0x10/0x18
>> [<ffffffff806680e8>] device_online+0x56/0x72
>> [<ffffffff80668190>] online_store+0x8c/0xae
>> [<ffffffff80662dde>] dev_attr_store+0xe/0x1a
>> [<ffffffff802b53bc>] sysfs_kf_write+0x2e/0x4c
>> [<ffffffff802b4750>] kernfs_fop_write_iter+0xe8/0x14e
>> [<ffffffff80230170>] vfs_write+0x2a4/0x3e0
>> [<ffffffff802303e8>] ksys_write+0x5e/0xc8
>> [<ffffffff80230460>] sys_write+0xe/0x16
>> [<ffffffff80a4a8de>] do_trap_ecall_u+0xe0/0xf4
>> [<ffffffff80003e8c>] ret_from_exception+0x0/0x64
>> irq event stamp: 12335
>> hardirqs last  enabled at (12335): [<ffffffff8007e542>] console_unlock+0x156/0x186
>> hardirqs last disabled at (12334): [<ffffffff8007e52c>] console_unlock+0x140/0x186
>> softirqs last  enabled at (12154): [<ffffffff80a560d0>] __do_softirq+0x3b0/0x470
>> softirqs last disabled at (12147): [<ffffffff80019340>] __irq_exit_rcu+0xa6/0xd0
>> ---[ end trace 0000000000000000 ]---
>> ------------[ cut here ]------------
>> kernel BUG at kernel/irq_work.c:245!
>> Kernel BUG [#1]
>> Modules linked in:
>> CPU: 0 PID: 215 Comm: bash Tainted: G        W          6.5.0-rc1+ #7524
>> Hardware name: riscv-virtio,qemu (DT)
>> epc : irq_work_run_list+0x30/0x32
>>   ra : irq_work_run+0x2a/0x4c
>> ...
>> [<ffffffff8011a346>] irq_work_run_list+0x30/0x32
>> [<ffffffff8011a372>] irq_work_run+0x2a/0x4c
>> [<ffffffff800c9aec>] smpcfd_dying_cpu+0x12/0x1c
>> [<ffffffff80012b2e>] cpuhp_invoke_callback+0x124/0x322
>> [<ffffffff800142f8>] _cpu_up+0x218/0x322
>> [<ffffffff8001445e>] cpu_up+0x5c/0x98
>> [<ffffffff80014bb8>] cpu_device_up+0x14/0x1c
>> [<ffffffff8066d68e>] cpu_subsys_online+0x10/0x18
>> [<ffffffff806680e8>] device_online+0x56/0x72
>> [<ffffffff80668190>] online_store+0x8c/0xae
>> [<ffffffff80662dde>] dev_attr_store+0xe/0x1a
>> [<ffffffff802b53bc>] sysfs_kf_write+0x2e/0x4c
>> [<ffffffff802b4750>] kernfs_fop_write_iter+0xe8/0x14e
>> [<ffffffff80230170>] vfs_write+0x2a4/0x3e0
>> [<ffffffff802303e8>] ksys_write+0x5e/0xc8
>> [<ffffffff80230460>] sys_write+0xe/0x16
>> [<ffffffff80a4a8de>] do_trap_ecall_u+0xe0/0xf4
>> [<ffffffff80003e8c>] ret_from_exception+0x0/0x64
>> Code: 8526 6084 f0ef f71f fce5 60e2 6442 64a2 6105 8082 (9002) 1101
>> ---[ end trace 0000000000000000 ]---
>> Kernel panic - not syncing: Fatal exception in interrupt
>> SMP: stopping secondary CPUs
>> SMP: failed to stop secondary CPUs 0-1
>> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>>
>> To avoid calling those checks in the CPU hot-plug paths again and again,
>> simply move the check at the beginning of the check_unaligned_access()
>> function and rely on the value determined during the system boot.
>>
>> Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
>> Fixes: c20d36cc2a20 ("riscv: don't probe unaligned access speed if already done")
>> Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
>> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> Hi Marek,
> Thanks for the patch. I happened to spot that bug too
> (check_unaligned_access_emulated() clobbering the per-cpu variable
> back to unknown). Since I was rearranging that code to try to run the
> speed measurements in parallel, I moved that check around to hopefully
> solve the same issue you're reporting. Can you see if this patch also
> fixes your issue:
> https://lore.kernel.org/lkml/20231106225855.3121724-1-evan@rivosinc.com/
> . It's also in Palmer's for-next tree as 55e0bf49a0d0 ("RISC-V: Probe
> misaligned access speed in parallel").

Thanks for for the information. Yes, Your patch also fixes this issue, 
but it is a bit invasive (it perfectly fits for the -next material 
though). Maybe my little cleanup could be applied as a fix during -rc 
cycle? It has an advantage that it can be easily backported to v6.6-stable.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

