Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8380452F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344290AbjLECnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbjLECnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:43:24 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0AFCD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:43:30 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d87a83ec27so1843924a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 18:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701744209; x=1702349009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8shb2vOgFxVQBulBoS+RFCfV8Kg5/sOHgmT3prY59dw=;
        b=xKefC/obayeESa/5typRyjL4zw3B87uJAxa83T76WyBaBy6SZqlpF7GRi+0BwJyktC
         +j5KiUgta/8kLTvwR4OQt3sWXEGhaITSYRMyhB2m4xmCKdZX9ns+ng5IAf7WN2q/XqJ3
         UF6211AEHX534nesayav+PM00vKH5aS40hMvWllbqANpLXgJCQjlR+p0iJtg1SYeciMy
         ou4QNm1Le+zjKidn/B9Eka12WHP2XrZfG4jWLroiZtEqPEbgRDHgBalU0ptVtmu/cPjx
         tLaLauhapeOUeZQKvlmikSv/y1k+0/q5CyqP8Z+vw3OYQPlRHoCoSMZN1kGbty7f2pUb
         6TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701744209; x=1702349009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8shb2vOgFxVQBulBoS+RFCfV8Kg5/sOHgmT3prY59dw=;
        b=Nn+BVQcAQpmciRlNBOwAA5k7P437uBlL9GPyaesPs0HIohUdR54enTSRzeQtBfYwhq
         GFee6XvfM5Dqr/6KHklUcVjShPyTIsuTarC+8HN8YDc8GmKcZvKblyaoaT/J0LQkKtI2
         thgTOJIif6aMGt2cvgGqRApm82cH52gUYWyz1unGftQXdSAOyb83q2wQHNEJh5Lyd7Dz
         KsJ9JHyOSshMWf+0g1Qium0jhd++QsQPhQxNf+gzMGOmOUWZaClFlleGCEHjQFFRixo/
         ckoy4lOaq3RLLNBrm0LI7idXhEVe5RShcmuujIjC81vlniZdPP5BG9lT8bPI53dsCGyF
         0ZdQ==
X-Gm-Message-State: AOJu0Yyqkpr9Phj4pklrmgI5+uUaOKMa0c4A9YDfAZx2YwIBgmnioo4c
        k8Awma72fyvRgcFuhon3g2MjofLe71+aMJ9/O1UQKg==
X-Google-Smtp-Source: AGHT+IERJeMapF5PThubupdp2gUedh1EYiqTSK4UR98xxgpusphnbq2HPdJsCgSUiJ59GqUNJjyTkQ==
X-Received: by 2002:a9d:75cd:0:b0:6d8:8053:af56 with SMTP id c13-20020a9d75cd000000b006d88053af56mr3847989otl.39.1701744209114;
        Mon, 04 Dec 2023 18:43:29 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a9d62d1000000b006b9848f8aa7sm2157655otk.45.2023.12.04.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:43:28 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 0/9] RISC-V SBI v2.0 PMU improvements and Perf sampling in KVM guest
Date:   Mon,  4 Dec 2023 18:43:01 -0800
Message-Id: <20231205024310.1593100-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements SBI PMU improvements done in SBI v2.0[1] i.e. PMU snapshot
and fw_read_hi() functions. 

SBI v2.0 introduced PMU snapshot feature which allows the SBI implementation
to provide counter information (i.e. values/overlfow status) via a shared
memory between the SBI implementation and supervisor OS. This allows to minimize
the number of traps in when perf being used inside a kvm guest as it relies on
SBI PMU + trap/emulation of the counters. 

The current set of ratified RISC-V specification also doesn't allow scountovf
to be trap/emulated by the hypervisor. The SBI PMU snapshot bridges the gap
in ISA as well and enables perf sampling in the guest. However, LCOFI in the
guest only works via IRQ filtering in AIA specification. That's why, AIA
has to be enabled in the hardware (at least the Ssaia extension) in order to
use the sampling support in the perf. 

Here are the patch wise implementation details.

PATCH 1-2 : Generic cleanups/improvements.
PATCH 3,4,9 : FW_READ_HI function implementation
PATCH 5-6: Add PMU snapshot feature in sbi pmu driver
PATCH 7-8: KVM implementation for snapshot and sampling in kvm guests

The series is based on v6.70-rc3 and is available at:

https://github.com/atishp04/linux/tree/kvm_pmu_snapshot_v1

The kvmtool patch is also available at:
https://github.com/atishp04/kvmtool/tree/sscofpmf

It also requires Ssaia ISA extension to be present in the hardware in order to
get perf sampling support in the guest. In Qemu virt machine, it can be done
by the following config.

```
-cpu rv64,sscofpmf=true,x-ssaia=true
```

There is no other dependancies on AIA apart from that. Thus, Ssaia must be disabled
for the guest if AIA patches are not available. Here is the example command.

```
./lkvm-static run -m 256 -c2 --console serial -p "console=ttyS0 earlycon" --disable-ssaia -k ./Image --debug 
```

The series has been tested only in Qemu.
Here is the snippet of the perf running inside a kvm guest.

===================================================
# perf record -e cycles -e instructions perf bench sched messaging -g 5
...
# Running 'sched/messaging' benchmark:
...
[   45.928723] perf_duration_warn: 2 callbacks suppressed
[   45.929000] perf: interrupt took too long (484426 > 483186), lowering kernel.perf_event_max_sample_rate to 250
# 20 sender and receiver processes per group
# 5 groups == 200 processes run

     Total time: 14.220 [sec]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.117 MB perf.data (1942 samples) ]
# perf report --stdio
# To display the perf.data header info, please use --header/--header-only optio>
#
#
# Total Lost Samples: 0
#
# Samples: 943  of event 'cycles'
# Event count (approx.): 5128976844
#
# Overhead  Command          Shared Object                Symbol               >
# ........  ...............  ...........................  .....................>
#
     7.59%  sched-messaging  [kernel.kallsyms]            [k] memcpy
     5.48%  sched-messaging  [kernel.kallsyms]            [k] percpu_counter_ad>
     5.24%  sched-messaging  [kernel.kallsyms]            [k] __sbi_rfence_v02_>
     4.00%  sched-messaging  [kernel.kallsyms]            [k] _raw_spin_unlock_>
     3.79%  sched-messaging  [kernel.kallsyms]            [k] set_pte_range
     3.72%  sched-messaging  [kernel.kallsyms]            [k] next_uptodate_fol>
     3.46%  sched-messaging  [kernel.kallsyms]            [k] filemap_map_pages
     3.31%  sched-messaging  [kernel.kallsyms]            [k] handle_mm_fault
     3.20%  sched-messaging  [kernel.kallsyms]            [k] finish_task_switc>
     3.16%  sched-messaging  [kernel.kallsyms]            [k] clear_page
     3.03%  sched-messaging  [kernel.kallsyms]            [k] mtree_range_walk
     2.42%  sched-messaging  [kernel.kallsyms]            [k] flush_icache_pte

===================================================

[1] https://github.com/riscv-non-isa/riscv-sbi-doc

Atish Patra (9):
RISC-V: Fix the typo in Scountovf CSR name
drivers/perf: riscv: Add a flag to indicate SBI v2.0 support
RISC-V: Add FIRMWARE_READ_HI definition
drivers/perf: riscv: Read upper bits of a firmware counter
RISC-V: Add SBI PMU snapshot definitions
drivers/perf: riscv: Implement SBI PMU snapshot function
RISC-V: KVM: Implement SBI PMU Snapshot feature
RISC-V: KVM: Add perf sampling support for guests
RISC-V: KVM: Support 64 bit firmware counters on RV32

arch/riscv/include/asm/csr.h          |   5 +-
arch/riscv/include/asm/errata_list.h  |   2 +-
arch/riscv/include/asm/kvm_vcpu_pmu.h |  16 +-
arch/riscv/include/asm/sbi.h          |  11 ++
arch/riscv/include/uapi/asm/kvm.h     |   1 +
arch/riscv/kvm/main.c                 |   1 +
arch/riscv/kvm/vcpu.c                 |   8 +-
arch/riscv/kvm/vcpu_onereg.c          |   1 +
arch/riscv/kvm/vcpu_pmu.c             | 232 ++++++++++++++++++++++++--
arch/riscv/kvm/vcpu_sbi_pmu.c         |  10 ++
drivers/perf/riscv_pmu.c              |   1 +
drivers/perf/riscv_pmu_sbi.c          | 219 ++++++++++++++++++++++--
include/linux/perf/riscv_pmu.h        |   6 +
13 files changed, 478 insertions(+), 35 deletions(-)

--
2.34.1

