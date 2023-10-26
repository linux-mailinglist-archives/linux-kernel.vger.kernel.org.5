Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459627D84C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbjJZObd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345244AbjJZObb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:31:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BF5D42
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:31:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32da02fca9aso103610f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698330687; x=1698935487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=704Flyy7JmjBNi+vrzBFMAfESwzm4xcRGzYRJGjJNUk=;
        b=j6cgvH5VWx9Nd2IyIcfvuaD3zSpF6Z4Xm2tNnESVPI3c0fyxg0GoIj3HO0SUYbibWV
         j9bjonOiq/D3RlRPUjN9+eLUikBEODjiw5CbcQi8ZHKYjv54j8CH/QFgWPY35nfvt0ZS
         i1ps13Jduj4gPWBggt6fRRDO3dfppN1Cuyg/0RFF7tzC1QXfqPeBSObYu2Sp8DitCfbR
         7EPBrhQLdcBPRyqseuU5Kk4tWccoNl0nrFYhZEZjHSNiK1WK858VSxCL+8hN3q8QPvkY
         qAlhK1fIk2EG2uEHnNDIysHXx6DtIINqRypSpsmzfQzoeSsZfdja6CtWRi27yS6y2wGW
         aKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330687; x=1698935487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=704Flyy7JmjBNi+vrzBFMAfESwzm4xcRGzYRJGjJNUk=;
        b=wer9/oNTTV7WSrW4USCyhW/ngX2OlQOfN5FVdOSsTLBzlBTjCKI7nOX1RRH97IL0dq
         AnH4pKlqAqRveoaonCWrSoFXGnUipTrxTr4508GIGykZTX61NUWktAj9BO7e4aM/mQqq
         DgFuqZDJibs+fegIlfjYDr5SFu+mN7f2v5sa5rM/4Bm+4kG+2cTHbfDkSj7teooYYFGX
         /1rjuVSoO0VVtduItXX4yniby6eexB/G+jhHaX69Y05oA2sWk3VHJLQ2CXGujFE7aoMT
         Bv6DoL2VAOsjH08ulowxhFWgStfGx8CDl5sxBqtRq6NbDP+768dYkfqScqOTjeyH9dzY
         FhmA==
X-Gm-Message-State: AOJu0YwH3QzIILze9IAL/q/o3UwnDQ5YxOH3BbVbFs1Jld2dghJMwbC1
        7j+Ahnnxn9j9UeBrV+zpmfoEXA==
X-Google-Smtp-Source: AGHT+IGGS8KnMtYMw9jVJnd0yOMEqJbxVZiWH5Aj4AZIhVK0vIfZ2PSwmXaPa8ekX7sIAeERTvK8aQ==
X-Received: by 2002:a05:6000:1e87:b0:32d:f126:5a57 with SMTP id dd7-20020a0560001e8700b0032df1265a57mr10474423wrb.3.1698330686591;
        Thu, 26 Oct 2023 07:31:26 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:b380:32be:257:5381])
        by smtp.gmail.com with ESMTPSA id r9-20020a056000014900b003232f167df5sm14316589wrx.108.2023.10.26.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:31:26 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Himanshu Chauhan <hchauhan@ventanamicro.com>,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH 0/3] riscv: add support for SBI Supervisor Software Events
Date:   Thu, 26 Oct 2023 16:31:19 +0200
Message-ID: <20231026143122.279437-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI Supervisor Software Events (SSE) extensions provides a mechanism
to inject software events from an SBI implementation to supervisor
software such that it preempts all other supervisor level traps and
interrupts [1].

Various events are defined and can be send asynchronously to supervisor
software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
as platform specific events. Events can be either local (per-hart) or
global. Events can be nested on top of each other based on priority and
can interrupt the kernel at any time.

First patch adds the SSE definitions. Second one adds support for SSE
itself. Implementation is split between arch specific code and generic
part (similarly to what is done for ARM SDEI). Finally, the last patch
add support fro SSE event in the SBI PMU driver. If the SSE event is
available from the SBI then, it will be used instead of the normal
interrupt.

Amongst the specific points that needs to be handle is the interruption
at any point of the kernel execution and more specifically during
exception handling. Due to the fact that the exception entry
implementation uses the SCRATCH CSR as both the current task struct and
as the temporary register to switch the stack and save register, it is
difficult to reliably get the current task struct if we get interrupted
at this specific moment. A fixup-like mechanism allows to mark the
location of the current task struct depending on the entry level
(user/kernel) and the location. This is then used in the SSE assembly to
determine where is located the current task_struct.

Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
handled and does not adds any overhead to existing code. Moreover, it
provides "true" NMI-like interrupts which can interrupt the kernel at
any time (even in exception handling). This is particularly crucial for
RAS errors which needs to be handled as fast as possible to avoid any
fault propagation. Additionally, SSE event handling is faster that the
standard IRQ handling path with almost half executed instruction (700 vs
1590). Some complementary tests/perf measurements will be done.

For testing purpose, one can use the provided SBI implementation at [3].
This series also needs patch [4] to fix a bug in the PMU driver.

Link: https://lists.riscv.org/g/tech-prs/message/515 [1]
Link: https://lore.kernel.org/lkml/20231023082911.23242-10-luxu.kernel@bytedance.com/T/ [2]
Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/sse [3]
Link: https://lore.kernel.org/linux-arm-kernel/20231026084010.11888-1-alexghiti@rivosinc.com/ [4]

---

Clément Léger (3):
  riscv: add SBI SSE extension definitions
  riscv: add support for SBI Supervisor Software Events extension
  perf: RISC-V: add support for SSE event

 arch/riscv/include/asm/asm-prototypes.h |   5 +
 arch/riscv/include/asm/sbi.h            |  40 ++
 arch/riscv/include/asm/sse.h            |  94 +++++
 arch/riscv/kernel/Makefile              |   1 +
 arch/riscv/kernel/asm-offsets.c         |  17 +
 arch/riscv/kernel/entry.S               | 156 ++++++++
 arch/riscv/kernel/sbi.c                 |   4 +
 arch/riscv/kernel/sse.c                 |  97 +++++
 arch/riscv/kernel/stacktrace.c          |  13 +
 arch/riscv/kernel/vmlinux.lds.S         |   6 +
 drivers/firmware/Kconfig                |  10 +
 drivers/firmware/Makefile               |   1 +
 drivers/firmware/riscv_sse.c            | 496 ++++++++++++++++++++++++
 drivers/perf/riscv_pmu_sbi.c            |  51 ++-
 include/linux/riscv_sse.h               |  56 +++
 15 files changed, 1038 insertions(+), 9 deletions(-)
 create mode 100644 arch/riscv/include/asm/sse.h
 create mode 100644 arch/riscv/kernel/sse.c
 create mode 100644 drivers/firmware/riscv_sse.c
 create mode 100644 include/linux/riscv_sse.h

-- 
2.42.0

