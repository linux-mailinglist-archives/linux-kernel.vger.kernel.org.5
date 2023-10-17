Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142C57CBD09
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjJQIEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:04:32 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9230A93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:04:30 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-49d6bd3610cso2242279e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697529869; x=1698134669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xyr6PCHw9JRkGbBkheAbktViQfs7PkRAlmVWx9O5GDc=;
        b=CkvYQOdJhYT5ULhLaNXjYCwVxoozpAGqDDvNXtE0PHHhWXEhHysFmZk3tFqSEVirCL
         uXsc4roxJPNb7eKP+aZ2ClXyUXibybEiEmeBd8BcBDexrQvGzv3xV3m3zSi5WP5otyDi
         6b3aORBPubnlrpu2n9p982iTjqCOf6G78PxuRJAk01ExicFvWUkvoNf1yN4RHWdx5LVA
         yoRFbToydlDBiR3pyesmHdp8xQozmtRNnZFsvC7zNxEpZXMBimiMoG60WsEFK70ZP8oW
         tScH8n+c3ekscIlh8+evGTKGtbnvbT0KebMCLQMnE5nHFsoqF58IknZAotFHJ7I5myNy
         o6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529869; x=1698134669;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyr6PCHw9JRkGbBkheAbktViQfs7PkRAlmVWx9O5GDc=;
        b=iNQ1mUMrQ1DSLLWYAq6kmZRON1MW99CrmViZ1+F3P4PfgACbTjWM2Sldk+k/nr7r0N
         y1vlueJM0j+424viTBT/M8vUEbGzefgFm29Be+IT00a9NqXf4QaseivA1FyZBG7/YilM
         WMaOEZ3Ao5haf7i2VysBc84vtiDlaZU5UsII4L3fT7TTJrTwOBoiEOuZm8YQdkRAP/y0
         sP4KNsmDNq+iLnHw4ZMz4i36XSKSPcyNotH7+BtwpOiDwHthRDfWOIN/7ARvAtFk9gDl
         g4nICGYKofnqdwV8tkWU4Sf5aiBS2/F+95bx2WdztNSIBCp3fJle+UrBKvpKRIbo8G1n
         Uusg==
X-Gm-Message-State: AOJu0Yy7dzdXIIp/4ECzb92cgKvod4NMiPu44e9kP0IJ0UUUfGu9lKGQ
        6rhOOoEUdzgzwuNoYsOHEn2qmRCYN5OFa9YYR9F1gg==
X-Google-Smtp-Source: AGHT+IFd8g20QMfQ9E+xAkgr4VcpkF0gtl3Ph4qFIqtHJosckdm5kRSN7IwlaUOeiZeRSHHi1MPTY6P2HKQQtLP++qU=
X-Received: by 2002:a05:6122:c96:b0:49a:c339:11b9 with SMTP id
 ba22-20020a0561220c9600b0049ac33911b9mr1813954vkb.11.1697529869549; Tue, 17
 Oct 2023 01:04:29 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Oct 2023 13:34:18 +0530
Message-ID: <CA+G9fYtEGe_DhY2Ms7+L7NKsLYUomGsgqpdBj+QwDLeSg=JhGg@mail.gmail.com>
Subject: selftests: ftrace: Internal error: Oops: sve_save_state
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-stable <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed while running selftests: ftrace:
ftracetest-ktap on FVP models running stable-rc 6.5.8-rc2.

This is not an easy to reproduce issue and not seen on mainline and next.
We are investigating this report.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>


Test log:
----------
kselftest: Running tests in ftrace
TAP version 13
1..1
# timeout set to 0
# selftests: ftrace: ftracetest-ktap
# TAP version 13
# 1..129
# ok 1 Basic trace file check
# ok 2 Basic test for tracers
# ok 3 Basic trace clock test
# ok 4 Basic event tracing check
# ok 5 Change the ringbuffer size
# ok 6 Snapshot and tracing setting
# ok 7 Snapshot and tracing_cpumask
# ok 8 trace_pipe and trace_marker
[  471.689140]
[  471.689264] **********************************************************
[  471.689422] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[  471.689574] **                                                      **
[  471.689716] ** trace_printk() being used. Allocating extra memory.  **
[  471.689878] **                                                      **
[  471.690031] ** This means that this is a DEBUG kernel and it is     **
[  471.690183] ** unsafe for production use.                           **
[  471.690335] **                                                      **
[  471.690487] ** If you see this message and you are not debugging    **
[  471.690728] ** the kernel, report this immediately to your vendor!  **
[  471.690881] **                                                      **
[  471.691033] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[  471.691185] **********************************************************
[  543.243648] hrtimer: interrupt took 11937170 ns
[  764.987161] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  764.992518] Mem abort info:
[  764.995330]   ESR = 0x0000000096000044
[  764.998562]   EC = 0x25: DABT (current EL), IL = 32 bits
[  765.002434]   SET = 0, FnV = 0
[  765.005361]   EA = 0, S1PTW = 0
[  765.008327]   FSC = 0x04: level 0 translation fault
[  765.012011] Data abort info:
[  765.014858]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[  765.018797]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[  765.022562]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  765.026438] user pgtable: 4k pages, 48-bit VAs, pgdp=00000008848bd000
[  765.030782] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  765.037045] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
[  765.038392] Modules linked in: ftrace_direct pl111_drm arm_spe_pmu
drm_dma_helper crct10dif_ce panel_simple drm_kms_helper fuse drm
dm_mod ip_tables x_tables [last unloaded: ftrace_direct]
[  765.044892] CPU: 3 PID: 808 Comm: rmmod Not tainted 6.5.8-rc2 #1
[  765.046192] Hardware name: FVP Base RevC (DT)
[  765.047264] pstate: 234020c9 (nzCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  765.048693] pc : sve_save_state+0x4/0xf0
[  765.049820] lr : fpsimd_save+0x1b8/0x218
[  765.050933] sp : ffff800080a83ac0
[  765.051871] x29: ffff800080a83ac0 x28: ffff000805257058 x27: 0000000000000001
[  765.054108] x26: 0000000000000000 x25: ffffd7c64d332980 x24: 0000000000000000
[  765.056341] x23: 0000000000000001 x22: ffff284232103000 x21: 0000000000000040
[  765.058575] x20: ffff00087f7470b0 x19: ffffd7c64d6440b0 x18: 0000000000000000
[  765.060811] x17: 0000000000000000 x16: ffff800080018000 x15: 0000000000000000
[  765.063041] x14: 0000000000000000 x13: 0000000000000000 x12: 0000380a873b560e
[  765.065277] x11: ffffd7c64e0ae390 x10: ffff800080a83b10 x9 : ffffd7c64b5b7710
[  765.067516] x8 : ffff800080a839b8 x7 : 000000000000001e x6 : ffff00080000c200
[  765.069752] x5 : ffffd7c64b78cc30 x4 : 0000000000000000 x3 : 0000000000000000
[  765.071983] x2 : 0000000000000001 x1 : ffff000805257820 x0 : 0000000000000880
[  765.074221] Call trace:
[  765.075045]  sve_save_state+0x4/0xf0
[  765.076138]  fpsimd_thread_switch+0x2c/0xe8
[  765.077305]  __switch_to+0x20/0x158
[  765.078384]  __schedule+0x2cc/0xb38
[  765.079464]  preempt_schedule_irq+0x44/0xa8
[  765.080633]  el1_interrupt+0x4c/0x68
[  765.081691]  el1h_64_irq_handler+0x18/0x28
[  765.082829]  el1h_64_irq+0x64/0x68
[  765.083874]  ftrace_return_to_handler+0x98/0x158
[  765.085090]  return_to_handler+0x20/0x48
[  765.086205]  do_sve_acc+0x64/0x128
[  765.087272]  el0_sve_acc+0x3c/0xa0
[  765.088356]  el0t_64_sync_handler+0x114/0x130
[  765.089524]  el0t_64_sync+0x190/0x198
[  765.090712] Code: d51b4408 d65f03c0 d503201f d503245f (e5bb5800)
[  765.092024] ---[ end trace 0000000000000000 ]---
[  765.904294] pstore: backend (efi_pstore) writing error (-5)
[  765.905531] note: rmmod[808] exited with irqs disabled

Links:
test log link:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.5.y/build/v6.5.7-191-gbe4ec7370801/testrun/20672437/suite/log-parser-test/test/check-kernel-oops/log

Details of tests:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WrHwIIFdZpJWV5smWZVr2yJxl1

Build link:
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2WrHvExYOOOZVoxlISTdAD1gMzO/


--
Linaro LKFT
https://lkft.linaro.org
