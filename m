Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1245D7D2CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjJWI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJWI3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:29:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD84BC0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c77449a6daso24818165ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049761; x=1698654561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2Go0p6zVY7hIr9Nax8xzpGmWWVF8MFp+pn8gehqpE8=;
        b=M6bm7WAWDiC96MnOnkLju3tgFhcLE1okBLJZ8vBop5J1QByBVUp0QWdSyNe+JIJNr7
         JpHsm4yRoq6H15NNj6qvJApqqPLTExs3SsZ9/u7Fy+ac2BeEHUwKcjZMsNKNEa1dT6LP
         QVGvhgCEIjjl6uHS09AthIQ6scCVZrNM+PEhvpQ2q2MC67vUm88HmBWUdxRMsQgW1nRk
         1jvM37oC6c8yH8H/Ahc1TIXwKUJFgYWvl6AjMSBSZWeIvD3Muab7UMCnVFPOLMedqUgs
         zgqAS85G3qMcZD6j7/C9AMJcD+nIlq5iK4AfVyVMhmO4nFIYhXv3xfJoqmXSeDYyMNrH
         DRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049761; x=1698654561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2Go0p6zVY7hIr9Nax8xzpGmWWVF8MFp+pn8gehqpE8=;
        b=rAoRAEAIyOd9rE5epxqaDTXff8+njA0s3WHU3DffDoCCMGKRHqOiHBHre9nXN/p/l6
         zejOcqVRToSSWKCGkeidMJLn+i0n3MZ8L2ZW4cPpIblqTDvmBneksf3iwGx+2atFBLQ/
         CVPa4CKA8QYEVRWywHMpULyFeJMWVO1qNf6kCWYu/CB5vRMQbxPacNTHNEH23XZHCwzY
         5nqHM4+y+DBEPO0W0J+1aHWa8GKs2zo+v/nyEZLGoipExEJGYUv/hQxdSJs6HZ7GkQ3q
         1y8G/c/5AchTEO8khSGBrvez5ZQPfleZfKt3ZkHOUu80WMjc1o4RaS5VkkVTwnPbaaRz
         +goA==
X-Gm-Message-State: AOJu0YyftnrSAa853l9mdtADwq4SpuUwd9lscZV3cxc7nMVeMKpXvqia
        wM08blEdxgPXUr0DSSk9ygUFjQ==
X-Google-Smtp-Source: AGHT+IGi2isItH5oJEzGONJXBXMRlFVQKtBwLtQlBx496PMYqU6jickbKx4YTcMVHuLvS4rb4D/zZw==
X-Received: by 2002:a17:903:4111:b0:1c4:3cd5:4298 with SMTP id r17-20020a170903411100b001c43cd54298mr7877870pld.18.1698049761112;
        Mon, 23 Oct 2023 01:29:21 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.29.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:29:20 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 00/12] riscv: Introduce Pseudo NMI
Date:   Mon, 23 Oct 2023 16:28:59 +0800
Message-Id: <20231023082911.23242-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to resend this patch series as I forgot to Cc the open list before.
Below is formal content.

The existing RISC-V kernel lacks an NMI mechanism as there is still no
ratified resumable NMI extension in RISC-V community, which can not
satisfy some scenarios like high precision perf sampling. There is an  
incoming hardware extension called Smrnmi which supports resumable NMI
by providing new control registers to save status when NMI happens.
However, it is still a draft and requires privilege level switches for
kernel to utilize it as NMIs are automatically trapped into machine mode.

This patch series introduces a software pseudo NMI mechanism in RISC-V.
The existing RISC-V kernel disables interrupts via per cpu control
register CSR_STATUS, the SIE bit of which controls the enablement of all
interrupts of whole cpu. When SIE bit is clear, no interrupt is enabled.
This patch series implements NMI by switching interrupt disable way to
another per cpu control register CSR_IE. This register controls the
enablement of each separate interrupt. Each bit of CSR_IE corresponds
to a single major interrupt and a clear bit means disablement of
corresponding interrupt.

To implement pseudo NMI, we switch to CSR_IE masking when disabling
irqs. When interrupts are disabled, all bits of CSR_IE corresponding to
normal interrupts are cleared while bits corresponding to NMIs are still
kept as ones. The SIE bit of CSR_STATUS is now untouched and always kept
as one.

We measured performacne of Pseudo NMI patches based on v6.6-rc4 on SiFive
FU740 Soc with hackbench as our benchmark. The result shows 1.90%
performance degradation.

  "hackbench 200 process 1000" (average over 10 runs)
  +-----------+----------+------------+
  |           | v6.6-rc4 | Pseudo NMI |
  +-----------+----------+------------+
  |   time    | 251.646s |  256.416s  |
  +-----------+----------+------------+

The overhead mainly comes from two parts:

  1. Saving and restoring CSR_IE register during kernel entry/return.
  This part introduces about 0.57% performance overhead.

  2. The extra instructions introduced by 'irqs_enabled_ie'. It is a
  special value representing normal CSR_IE when irqs are enabled. It is
  implemented via ALTERNATIVE to adapt to platforms without PMU. This
  part introduces about 1.32% performance overhead.

Limits:

  CSR_IE is now used for disabling irqs and any other code should
  not touch this register to avoid corrupting irq status, which means
  we do not support masking a single interrupt now.                                                                    

  We have tried to fix this by introducing a per cpu variable to save
  CSR_IE value when disabling irqs. Then all operatations on CSR_IE
  will be redirected to this variable and CSR_IE's value will be
  restored from this variable when enabling irqs. Obviously this method
  introduces extra memory accesses in hot code path.

TODO:

  1. The adaption to hypervisor extension is ongoing.

  2. The adaption to advanced interrupt architecture is ongoing.

This version of Pseudo NMI is rebased on v6.6-rc7.

Thanks in advance for comments.

Xu Lu (12):
  riscv: Introduce CONFIG_RISCV_PSEUDO_NMI
  riscv: Make CSR_IE register part of context
  riscv: Switch to CSR_IE masking when disabling irqs
  riscv: Switch back to CSR_STATUS masking when going idle
  riscv: kvm: Switch back to CSR_STATUS masking when entering guest
  riscv: Allow requesting irq as pseudo NMI
  riscv: Handle pseudo NMI in arch irq handler
  riscv: Enable NMIs during irqs disabled context
  riscv: Enable NMIs during exceptions
  riscv: Enable NMIs during interrupt handling
  riscv: Request pmu overflow interrupt as NMI
  riscv: Enable CONFIG_RISCV_PSEUDO_NMI in default

 arch/riscv/Kconfig                 | 10 ++++
 arch/riscv/include/asm/csr.h       | 17 ++++++
 arch/riscv/include/asm/irqflags.h  | 91 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/processor.h |  4 ++
 arch/riscv/include/asm/ptrace.h    |  7 +++
 arch/riscv/include/asm/switch_to.h |  7 +++
 arch/riscv/kernel/asm-offsets.c    |  3 +
 arch/riscv/kernel/entry.S          | 18 ++++++
 arch/riscv/kernel/head.S           | 10 ++++
 arch/riscv/kernel/irq.c            | 17 ++++++
 arch/riscv/kernel/process.c        |  6 ++
 arch/riscv/kernel/suspend_entry.S  |  1 +
 arch/riscv/kernel/traps.c          | 54 ++++++++++++++----
 arch/riscv/kvm/vcpu.c              | 18 ++++--
 drivers/clocksource/timer-clint.c  |  4 ++
 drivers/clocksource/timer-riscv.c  |  4 ++
 drivers/irqchip/irq-riscv-intc.c   | 66 ++++++++++++++++++++++
 drivers/perf/riscv_pmu_sbi.c       | 21 ++++++-
 18 files changed, 340 insertions(+), 18 deletions(-)

-- 
2.20.1

