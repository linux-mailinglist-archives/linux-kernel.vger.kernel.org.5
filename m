Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3077E7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjHPRye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbjHPRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8148C270D;
        Wed, 16 Aug 2023 10:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14F34618F9;
        Wed, 16 Aug 2023 17:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618DAC433C8;
        Wed, 16 Aug 2023 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692208450;
        bh=C3KpSEGvTHFdso9lkeVRktVz6+sn8+u/LTyv13MKxIc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ShGJ5XYIWCgpoe2NLz9exJSq3NoBUfpxcAErxGY7T4FIWMVvLC799TsZaCK0QU0lD
         BE4ynuqXUahcT1SbR9Xeh/kbGK4uayvk7twKlr8pMeV75Lxv9acXB1mh7jiZuc9Glg
         oL28d5NAulwBa6zAzLk3tPGnZz0ugXob+ULVuamy/GmsjkZ6BhFgihPS/lcxq18Ioc
         7l3A5y1Fvva1H4yqBufNbqDPm7O3nbdguHe3IzEinR+6mB6HgtCgrj5z7Ae2IvcR7V
         0l9Q7Oehj83eKOTwIzCVJ4eV01ceLhHyp6kWgcb7k+xn/9oVJDMR8QnPBsm0SPzJ6A
         LmoVHQjFx1YXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EAB5ECE06FA; Wed, 16 Aug 2023 10:54:09 -0700 (PDT)
Date:   Wed, 16 Aug 2023 10:54:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org
Cc:     peterz@infradead.org, keescook@chromium.org, elver@google.com,
        dvyukov@google.com, glider@google.com
Subject: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6 ff
 ff ff
Message-ID: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I hit the splat at the end of this message in recent mainline, and has
appeared some time since v6.5-rc1.  Should I be worried?

Reproducer on a two-socket hyperthreaded 20-core-per-socket x86 system:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5m --torture refscale --kcsan --kconfig "CONFIG_NR_CPUS=40" --kmake-args "CC=clang" --bootargs "refscale.scale_type=typesafe_seqlock refscale.nreaders=40 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot refscale.verbose_batched=5 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=5"

This is from overnight testing that hit this only in the KCSAN runs.
The KASAN and non-debug runs had no trouble.

This commit added the warning long ago:

65cdf0d623be ("x86/alternative: Report missing return thunk details")

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

[    0.281208] ------------[ cut here ]------------
[    0.281484] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6 ff ff ff
[    0.281514] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:753 apply_returns+0x2fc/0x450
[    0.283482] Modules linked in:
[    0.284489] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc6-00047-g21575bdc67ed #34195
[    0.285483] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    0.286482] RIP: 0010:apply_returns+0x2fc/0x450
[    0.287124] Code: ff ff 0f 0b e9 a9 fd ff ff c6 05 a1 0a 65 02 01 48 c7 c7 8b e3 2b b9 4c 89 ee 48 89 da b9 05 00 00 00 4d 89 e8 e8 04 f4 06 00 <0f> 0b e9 9a fe ff ff 85 db 0f 84 15 ff ff ff 48 c7 c7 4b e3 2b b9
[    0.287483] RSP: 0000:ffffffffb9603e00 EFLAGS: 00010246
[    0.288482] RAX: 22c53364d8918300 RBX: ffffffffb8b0e600 RCX: 0000000000000002
[    0.289482] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.290482] RBP: ffffffffb9603ee0 R08: 0000000080000003 R09: 0000000000000000
[    0.291481] R10: 0001ffffffffffff R11: ffffffffb9623800 R12: ffffffffb9603e18
[    0.292481] R13: ffffffffb8b0e605 R14: ffffffffba150a70 R15: ffffffffba150a68
[    0.293482] FS:  0000000000000000(0000) GS:ffff97305ec00000(0000) knlGS:0000000000000000
[    0.294481] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.295481] CR2: ffff973055601000 CR3: 0000000013a44000 CR4: 00000000000006f0
[    0.296483] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.297482] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.298482] Call Trace:
[    0.298859]  <TASK>
[    0.299185]  ? __warn+0x12c/0x330
[    0.299484]  ? apply_returns+0x2fc/0x450
[    0.300484]  ? report_bug+0x12a/0x1c0
[    0.301079]  ? handle_bug+0x3d/0x80
[    0.301483]  ? exc_invalid_op+0x1a/0x50
[    0.302041]  ? asm_exc_invalid_op+0x1a/0x20
[    0.302483]  ? __ret+0x5/0x7e
[    0.302903]  ? zen_untrain_ret+0x1/0x1
[    0.303487]  ? apply_returns+0x2fc/0x450
[    0.304003]  ? __ret+0x5/0x7e
[    0.304482]  ? __ret+0x14/0x7e
[    0.304869]  ? __ret+0xa/0x7e
[    0.305484]  ? unregister_die_notifier+0x4e/0x60
[    0.306063]  alternative_instructions+0x52/0x120
[    0.306489]  arch_cpu_finalize_init+0x2c/0x50
[    0.307068]  start_kernel+0x480/0x590
[    0.307485]  x86_64_start_reservations+0x24/0x30
[    0.308482]  x86_64_start_kernel+0xab/0xb0
[    0.309068]  secondary_startup_64_no_verify+0x17a/0x17b
[    0.309490]  </TASK>
[    0.309808] irq event stamp: 128439
[    0.310481] hardirqs last  enabled at (128457): [<ffffffffb7368401>] __up_console_sem+0x91/0xc0
[    0.311481] hardirqs last disabled at (128474): [<ffffffffb73683e6>] __up_console_sem+0x76/0xc0
[    0.312482] softirqs last  enabled at (128490): [<ffffffffb72cf624>] __irq_exit_rcu+0x64/0xd0
[    0.313481] softirqs last disabled at (128501): [<ffffffffb72cf624>] __irq_exit_rcu+0x64/0xd0
[    0.314481] ---[ end trace 0000000000000000 ]---
