Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D776231B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGYUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGYUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F751BC8;
        Tue, 25 Jul 2023 13:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA7A9618D3;
        Tue, 25 Jul 2023 20:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBABC433C8;
        Tue, 25 Jul 2023 20:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690316139;
        bh=pqx5kDelRKqTPu7atL1Isxd0it8WpiD0F7tdeKoFOSI=;
        h=Date:From:To:Cc:Subject:From;
        b=l6vyfcof74Ne0JCbUIZINN9KD3PxjuCCxWGRgVNz/PTUwN+pR+bRVVvq48q0FQqFv
         3VLLNTcejj07PHalk6gqyPyb7VU86CDKSFVW/h0svFWIIIKCidX6mN0xpWAvadT5lw
         JHBfxEU85FBkNMJXkAfCEXA/GbXkyvI/NC5Z9obku34BfXEu/9zlMsK3rMoNQszyLX
         eWy43qRudk6oFXtYMIfzQX+5GAxmaFcDPM4b7DaCuHmmeL31/Eq54+Gv4uiB3agJDg
         AOCfGdqIR0SyBez+1UuDQZjP1YTXe06xpTm5IGy9Q6LqZZUcYQaS3zP/pCEuSld0Cc
         Ny9siLdnTOpuQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82FF340516; Tue, 25 Jul 2023 17:15:35 -0300 (-03)
Date:   Tue, 25 Jul 2023 17:15:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: 'perf test sigtrap' failing on PREEMPT_RT_FULL
Message-ID: <ZMAtZ2t43GXoF6tM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco, Peter,

	I got a report that 'perf test sigtrap' test failed on a
PREEMPT_RT_FULL kernel, one that had up to:

commit 97ba62b278674293762c3d91f724f1bb922f04e0
Author: Marco Elver <elver@google.com>
Date:   Thu Apr 8 12:36:01 2021 +0200

    perf: Add support for SIGTRAP on perf events


	It failed with no sigtrap delivered, none of the nr-threads +
interactions (15000).

	Then I tried backporting up to the perf subsystem refactorings,
and then to what is in
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/log/?h=linux-6.4.y-rt,
but in both cases I ended up with the splat at the end of this message.

	I'll continue investigating, but thought it would be a good time
to report it.

- Arnaldo


[   52.848925] BUG: scheduling while atomic: perf/6549/0x00000002
[   52.848925] BUG: scheduling while atomic: perf/6547/0x00000002
[   52.848931] Modules linked in:
[   52.848931] Modules linked in:
[   52.848932]  nft_fib_inet
[   52.848931] BUG: scheduling while atomic: perf/6548/0x00000002
[   52.848932]  nft_fib_inet nft_fib_ipv4

<SNIP>

[   52.849055] Preemption disabled at:
[   52.849055] Preemption disabled at:
[   52.849055] Preemption disabled at:
[   52.849056] [<0000000000000000>] 0x0
[   52.849056] [<0000000000000000>] 0x0
[   52.849056] [<0000000000000000>] 0x0
[   52.849061] CPU: 2 PID: 6549 Comm: perf Not tainted 6.4.0-rt6+ #2
[   52.849064] Hardware name: LENOVO 427623U/427623U, BIOS 8BET45WW (1.25 ) 05/18/2011
[   52.849066] Call Trace:
[   52.849069]  <TASK>
[   52.849071]  dump_stack_lvl+0x33/0x50
[   52.849077]  __schedule_bug+0x9a/0xb0
[   52.849082]  schedule_debug.constprop.0+0x10f/0x140
[   52.849086]  __schedule+0x50/0x6c0
[   52.849090]  ? _raw_spin_lock+0x13/0x40
[   52.849093]  ? task_blocks_on_rt_mutex.constprop.0.isra.0+0x1b2/0x440
[   52.849096]  schedule_rtlock+0x1e/0x40
[   52.849099]  rtlock_slowlock_locked+0xf2/0x360
[   52.849102]  ? perf_ctx_enable+0x44/0x60
[   52.849106]  rt_spin_lock+0x41/0x60
[   52.849109]  do_send_sig_info+0x32/0xb0
[   52.849112]  send_sig_perf+0x70/0x90
[   52.849116]  perf_pending_task+0xb1/0xd0
[   52.849119]  task_work_run+0x59/0x90
[   52.849123]  exit_to_user_mode_loop+0x128/0x130
[   52.849128]  exit_to_user_mode_prepare+0xbd/0xd0
[   52.849131]  irqentry_exit_to_user_mode+0x5/0x30
[   52.849135]  asm_sysvec_irq_work+0x16/0x20
[   52.849138] RIP: 0033:0x55aa823bed63
[   52.849141] Code: 8b 04 25 28 00 00 00 48 89 45 e8 31 c0 e8 e5 03 f5 ff 4c 89 e7 48 89 c3 e8 da 1c f5 ff f0 01 1d a3 f4 91 00 8b 05 a5 f4 91 00 <83> f8 01 7e 1f 89 d9 31 d2 0f 1f 40 00 f0 01 0d 89 f4 91 00 8b 05
[   52.849143] RSP: 002b:00007f31341ccdb0 EFLAGS: 00000206
[   52.849145] RAX: 0000000000000bb8 RBX: 0000000000001995 RCX: 00007f31369aab44
[   52.849147] RDX: 0000000000000000 RSI: 0000000000000081 RDI: 00007fffcdbf8384
[   52.849148] RBP: 00007f31341ccdd0 R08: 00007fffcdbf8380 R09: 0000000000000006
[   52.849150] R10: 0000000000000000 R11: 0000000000000286 R12: 00007fffcdbf8380
[   52.849151] R13: 000000000000000d R14: 00007f31369ac530 R15: 0000000000000000
[   52.849156]  </TASK>
[   52.849157] CPU: 3 PID: 6547 Comm: perf Not tainted 6.4.0-rt6+ #2

[acme@nine linux]$ git log --oneline -10
d37d728e9a66 (HEAD, tag: v6.4-rt6, linux-rt-devel/linux-6.4.y-rt) v6.4-rt6
4d1139baae8b mm/page_alloc: Use write_seqlock_irqsave() instead write_seqlock() + local_irq_save().
dc93c1f07d48 seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
a3f6be6e5353 printk: Check only for migration in printk_deferred_*().
6dc15eb2a631 bpf: Remove in_atomic() from bpf_link_put().
0ccbab373cd7 (tag: v6.4-rt5) v6.4-rt5
786cdf91804d Merge tag 'v6.4' into linux-6.4.y-rt
6995e2de6891 (tag: v6.4, linux-rt-devel/master, linux-rt-devel/linux-6.4.y) Linux 6.4
e3b2e2c14bcc Merge tag 'i2c-for-6.4-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
547cc9be86f4 Merge tag 'perf_urgent_for_v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
[acme@nine linux]$

[acme@nine linux]$ uname -a
Linux nine 6.4.0-rt6+ #2 SMP PREEMPT_RT Sat Jul 22 08:52:53 -03 2023 x86_64 x86_64 x86_64 GNU/Linux

[acme@nine linux]$ cat /etc/os-release 
NAME="Red Hat Enterprise Linux"
VERSION="9.2 (Plow)"
ID="rhel"
ID_LIKE="fedora"
VERSION_ID="9.2"
PLATFORM_ID="platform:el9"
PRETTY_NAME="Red Hat Enterprise Linux 9.2 (Plow)"
ANSI_COLOR="0;31"
LOGO="fedora-logo-icon"
CPE_NAME="cpe:/o:redhat:enterprise_linux:9::baseos"
HOME_URL="https://www.redhat.com/"
DOCUMENTATION_URL="https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9"
BUG_REPORT_URL="https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT="Red Hat Enterprise Linux 9"
REDHAT_BUGZILLA_PRODUCT_VERSION=9.2
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION="9.2"
[acme@nine linux]$
