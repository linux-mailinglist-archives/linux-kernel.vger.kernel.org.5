Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A9E7E5587
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbjKHL3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHL32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:29:28 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A619A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:29:25 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231108112924euoutp02705e0eff21cba8929b662da8a4c5e847~Vol8vwFfL1401514015euoutp02c
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:29:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231108112924euoutp02705e0eff21cba8929b662da8a4c5e847~Vol8vwFfL1401514015euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699442964;
        bh=li73imUSCXRL1KLtY7SVTzDJF8se41kHvK+GR9zfnlY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=padvNFtCYxF+Sh5dBt2tBmy4dqtIygcxAvvVP+HZMxMVlJD70DbBJAMuefeBOvk4z
         LRJDQsmUSXZw7HICFDa8mGGa2JSU3WM7l+MwEY9BAFdQj75VqwC5H8aEEx7X1wFJWi
         AGCJKEHMDY9iVx5IYP2JgrUyuj96ZSNCfqn5IZ44=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231108112923eucas1p1d0be2cb9e1c6432a5391da0cfb60ff31~Vol8TdNcR1900119001eucas1p1Y;
        Wed,  8 Nov 2023 11:29:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5D.8F.11320.3117B456; Wed,  8
        Nov 2023 11:29:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3~Vol783UbC0768707687eucas1p2T;
        Wed,  8 Nov 2023 11:29:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231108112923eusmtrp292e05c11017f017fb2659021c103da80~Vol78MlCn1145311453eusmtrp2C;
        Wed,  8 Nov 2023 11:29:23 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-e8-654b711342dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6E.4E.25043.3117B456; Wed,  8
        Nov 2023 11:29:23 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231108112922eusmtip159190efd4fc28d99b4abf2982c2ba574~Vol7Mj0zD1977919779eusmtip1d;
        Wed,  8 Nov 2023 11:29:22 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH] riscv: fix potential panic during CPU hot-plug
Date:   Wed,  8 Nov 2023 12:29:09 +0100
Message-Id: <20231108112909.591987-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87rChd6pBhd+KlncmqRusfX3LHaL
        hSeTLaZs2sFucWSKncX/R69ZLZqPrWezuLxrDpvFts8tbBZrj9xlt3h5uYfZom0WvwOPx5uX
        L1k8Dnd8YffYtKqTzWPzknqPOz+WMnrcmBXh0bdlFaPHpebr7B7br81j9vj7cyuLx+dNcgHc
        UVw2Kak5mWWpRfp2CVwZO+d8Zio4p1WxqX0jUwNjq2oXIyeHhICJxIWLu5i6GLk4hARWMEos
        ffmWEcL5wigx5+ErdpAqIYHPjBK7lvnAdBzbshOqaDmjxIoNM5jhOo7/Xc0GUsUmYCjR9bYL
        zBYRcJS40dcLtoNZYCGzxNyrUxlBEsIC9hKbNk4Hs1kEVCUO/X4O1sArYCfx7Hg7I8Q6eYn9
        B88yQ8QFJU7OfMICYjMDxZu3zgbbLCHwgkNi86IdTBANLhK35nZB2cISr45vYYewZST+75zP
        BNHQziix4Pd9KGcCo0TD81tQ66wl7pz7BXQGB9AKTYn1u/Qhwo4SXb1rGUHCEgJ8EjfeCkIc
        wScxadt0Zogwr0RHmxBEtZrErOPr4NYevHCJGcL2kLi29jkzJEhjJS69+M00gVFhFpLXZiF5
        bRbCDQsYmVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJrTT/45/2cG4/NVHvUOMTByM
        hxglOJiVRHj/2nukCvGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgsky
        cXBKNTAV5J4NM/N54PlHZENE8aQ1MlGvo1tMEnpmvdT5dN173Zr2i0qnZZbz2Bf8urE3TfNP
        0NZdDKmyFcz8JVW5Ypa3HR/LarjGu8hae+zkadmdsDcyMeb8H8HTPGF1JxZXpXvdZD125dy5
        18FW7Q0iHxqNzp7I/L99o5nX1V9ZzFse3/guv9Xij5CLME+pRGnu9bVmsnr6gdwup4p2WB6Y
        /rPvUFEPe9Ere4G9jJ6rP6v4NrY8m8n040zDvz/T1lo28S4pZ3Fn2z5Jd3GZypvHtvFVa1Vk
        FS9uXnU89Vz9wx9XmSZaP3oqbMyzfY/Hr12vf0Tc91/8973CnxCOxyEVSySMffgnnz1gvP5R
        9Qe9L+uVWIozEg21mIuKEwFEB0uz1wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7rChd6pBl9nc1jcmqRusfX3LHaL
        hSeTLaZs2sFucWSKncX/R69ZLZqPrWezuLxrDpvFts8tbBZrj9xlt3h5uYfZom0WvwOPx5uX
        L1k8Dnd8YffYtKqTzWPzknqPOz+WMnrcmBXh0bdlFaPHpebr7B7br81j9vj7cyuLx+dNcgHc
        UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZO+d8
        Zio4p1WxqX0jUwNjq2oXIyeHhICJxLEtOxm7GLk4hASWMkrc+LaaESIhI3FyWgMrhC0s8eda
        FxtE0SdGif9/VjKBJNgEDCW63oIkODlEBJwlZv2bzwxSxCywklni7LLj7CAJYQF7iU0bp4NN
        ZRFQlTj0+zlYA6+AncSz4+1Q2+Ql9h88ywwRF5Q4OfMJC4jNDBRv3jqbeQIj3ywkqVlIUgsY
        mVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERtK2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrx/
        7T1ShXhTEiurUovy44tKc1KLDzGaAt03kVlKNDkfGMt5JfGGZgamhiZmlgamlmbGSuK8ngUd
        iUIC6YklqdmpqQWpRTB9TBycUg1MvG/yL+3XmJVnW/418sTX+qq2nDc6dvOvBzLEHjSIvFPM
        G7JvhnX+waftK/Ia5HWe+x8Q9v3zbjebrO2fu+rfop8vmdy6gy9t+Y8Td+8wVjFdc9jzXvdx
        IaPO9vIt1u4OsjVTay2X7Ni0OZfX+GTrSaM0fpUXfZ/c1pqJFs3ey5fyymB+3RtL/ocKNdPq
        JpT9mSn4OTw3HZg65a2eh0/8ESz9r976ctabnGeSSXkShyOmsMu2zfku8ec2Y1j/TNYG98e/
        qg49+Tij6vp+7V1rtSSXyscUNua6739imvJzQVyBG3fVbmP5S781RB592yAub1rJ8HP1ix07
        2TtCTee+Knht9SWmQvd2iDBftp0SS3FGoqEWc1FxIgA0BeAvLQMAAA==
X-CMS-MailID: 20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3
References: <CGME20231108112923eucas1p27474e921565e3f175e27e6598f0b71c3@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 584ea6564bca ("RISC-V: Probe for unaligned access speed") added a
test for unaligned access speed. It is being performed when given CPU is
onlined. Then, another test for misaligned access emulation has been
added in commit 71c54b3d169d ("riscv: report misaligned accesses
emulation to hwprobe"). This unaligned access speed doesn't really change
after the boot, so it is sufficient to do this test only once. This has
been partially added by commit c20d36cc2a20 ("riscv: don't probe
unaligned access speed if already done"), but this optimisation works
only if RISCV_HWPROBE_MISALIGNED_EMULATED is returned by the latter
check. Otherwise the 'misaligned_access_speed' pcpu varliable is
overwritten with RISCV_HWPROBE_MISALIGNED_UNKNOWN value, what makes the
first check to be always performed.

Recently I've noticed that the first check introduced a regression in the
CPU hot-plug mechanism. This can be observed as a following panic on
QEmu:

CPU1: off
cpu1: Ratio of byte access time to unaligned word access is 7.00, unaligned accesses are fast
CPU1: off
CPU1: failed to come online
------------[ cut here ]------------
WARNING: CPU: 0 PID: 215 at kernel/smp.c:437 __flush_smp_call_function_queue+0x90/0x292
Modules linked in:
CPU: 0 PID: 215 Comm: bash Not tainted 6.5.0-rc1+ #7524
Hardware name: riscv-virtio,qemu (DT)
epc : __flush_smp_call_function_queue+0x90/0x292
 ra : smpcfd_dying_cpu+0xe/0x1c
...
[<ffffffff800c904a>] __flush_smp_call_function_queue+0x90/0x292
[<ffffffff800c9ae8>] smpcfd_dying_cpu+0xe/0x1c
[<ffffffff80012b2e>] cpuhp_invoke_callback+0x124/0x322
[<ffffffff800142f8>] _cpu_up+0x218/0x322
[<ffffffff8001445e>] cpu_up+0x5c/0x98
[<ffffffff80014bb8>] cpu_device_up+0x14/0x1c
[<ffffffff8066d68e>] cpu_subsys_online+0x10/0x18
[<ffffffff806680e8>] device_online+0x56/0x72
[<ffffffff80668190>] online_store+0x8c/0xae
[<ffffffff80662dde>] dev_attr_store+0xe/0x1a
[<ffffffff802b53bc>] sysfs_kf_write+0x2e/0x4c
[<ffffffff802b4750>] kernfs_fop_write_iter+0xe8/0x14e
[<ffffffff80230170>] vfs_write+0x2a4/0x3e0
[<ffffffff802303e8>] ksys_write+0x5e/0xc8
[<ffffffff80230460>] sys_write+0xe/0x16
[<ffffffff80a4a8de>] do_trap_ecall_u+0xe0/0xf4
[<ffffffff80003e8c>] ret_from_exception+0x0/0x64
irq event stamp: 12335
hardirqs last  enabled at (12335): [<ffffffff8007e542>] console_unlock+0x156/0x186
hardirqs last disabled at (12334): [<ffffffff8007e52c>] console_unlock+0x140/0x186
softirqs last  enabled at (12154): [<ffffffff80a560d0>] __do_softirq+0x3b0/0x470
softirqs last disabled at (12147): [<ffffffff80019340>] __irq_exit_rcu+0xa6/0xd0
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kernel BUG at kernel/irq_work.c:245!
Kernel BUG [#1]
Modules linked in:
CPU: 0 PID: 215 Comm: bash Tainted: G        W          6.5.0-rc1+ #7524
Hardware name: riscv-virtio,qemu (DT)
epc : irq_work_run_list+0x30/0x32
 ra : irq_work_run+0x2a/0x4c
...
[<ffffffff8011a346>] irq_work_run_list+0x30/0x32
[<ffffffff8011a372>] irq_work_run+0x2a/0x4c
[<ffffffff800c9aec>] smpcfd_dying_cpu+0x12/0x1c
[<ffffffff80012b2e>] cpuhp_invoke_callback+0x124/0x322
[<ffffffff800142f8>] _cpu_up+0x218/0x322
[<ffffffff8001445e>] cpu_up+0x5c/0x98
[<ffffffff80014bb8>] cpu_device_up+0x14/0x1c
[<ffffffff8066d68e>] cpu_subsys_online+0x10/0x18
[<ffffffff806680e8>] device_online+0x56/0x72
[<ffffffff80668190>] online_store+0x8c/0xae
[<ffffffff80662dde>] dev_attr_store+0xe/0x1a
[<ffffffff802b53bc>] sysfs_kf_write+0x2e/0x4c
[<ffffffff802b4750>] kernfs_fop_write_iter+0xe8/0x14e
[<ffffffff80230170>] vfs_write+0x2a4/0x3e0
[<ffffffff802303e8>] ksys_write+0x5e/0xc8
[<ffffffff80230460>] sys_write+0xe/0x16
[<ffffffff80a4a8de>] do_trap_ecall_u+0xe0/0xf4
[<ffffffff80003e8c>] ret_from_exception+0x0/0x64
Code: 8526 6084 f0ef f71f fce5 60e2 6442 64a2 6105 8082 (9002) 1101
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Fatal exception in interrupt
SMP: stopping secondary CPUs
SMP: failed to stop secondary CPUs 0-1
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

To avoid calling those checks in the CPU hot-plug paths again and again,
simply move the check at the beginning of the check_unaligned_access()
function and rely on the value determined during the system boot.

Fixes: 584ea6564bca ("RISC-V: Probe for unaligned access speed")
Fixes: c20d36cc2a20 ("riscv: don't probe unaligned access speed if already done")
Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/riscv/kernel/cpufeature.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2f51dc4eaf77..3c502840a548 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -571,13 +571,13 @@ void check_unaligned_access(int cpu)
 	void *src;
 	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
 
-	if (check_unaligned_access_emulated(cpu))
-		return;
-
 	/* We are already set since the last check */
 	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
 		return;
 
+	if (check_unaligned_access_emulated(cpu))
+		return;
+
 	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
 	if (!page) {
 		pr_warn("Can't alloc pages to measure memcpy performance");
-- 
2.34.1

