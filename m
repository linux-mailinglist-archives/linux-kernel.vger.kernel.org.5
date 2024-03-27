Return-Path: <linux-kernel+bounces-120303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3913A88D58B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B87B22D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A393DAC14;
	Wed, 27 Mar 2024 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cwBfPqQI"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E436B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515040; cv=none; b=HQVFdJsX47x8atzRm3BD9E7TcxNeG/JI3mxyaXyRdW+zenKvLH+ha3DwkS8dq5ot3wuRnQpZHrqhf4kFM3+1DkfBUv5EwO6NngBrk9pqk3zuYBO4ZzYbB22VzFv0Q/P7Z4reOCUR96G1HgB45bKSXNgipoaOgsc/HoF5IaLz50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515040; c=relaxed/simple;
	bh=SO9fmJoujX51y/VSqlRW8TwKdxZQ2qnhf6MIK3VsWhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KA91+wCcNSgYstw7LD4Ms+tmmUVuE7VFPIHZvgjuLLPBqwCXgxy5Uu4Nt8MAehdC/9IuQ4BPvP3pbjsOavShclYz8utMiRdqo0Lp579bG48PrS/fxqM8jAlDrxsLUMtcH3DX5bwUfxCype31rPCcX1BgOqZwEg6CZhQiAmDXTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cwBfPqQI; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e6b01c3dc3so3646038a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515038; x=1712119838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CpKiyiacN2I6+hFCujZLl+xL41sMj3x+fr/3v5LupU=;
        b=cwBfPqQI5fRhJzo4uOAJz/I+25dhPJi6uGDHOtHv3kGZ9AOlr65NQY4013TKljAi6O
         Np100Bz7jOb8st56Px/0SyG5k7S/7YXKTtmj7nVQGWjeS7jSxy+MhurqFwjO0zV1AUSh
         780fTIHL0FcsfBVEQE1IZb1Ti9WZKRJCvBHUFGfUzSZQ23B5G89wCVsOwRhbLyNrzp1k
         kMStqMl0ClYE9o0I3PDAT2wFUjrpIrpSyO80+gXXxMIE/OPsHxUKWaQoL3GnlAWX8QVH
         La0E8W6rxzoTKRH62VRtQo4AgUN257T4RItaWMIqnULWAcV27uRmCQyM8oqFxMrgMxkd
         skvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515038; x=1712119838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CpKiyiacN2I6+hFCujZLl+xL41sMj3x+fr/3v5LupU=;
        b=vDBAL0VofXhZoyTZC8SFLWJoBfjablvaRP0CTXRRsPVyJU0GwRlBB2zqn/0RrupgSu
         Qjmf4bape5tkL3YdvuvZdJetQE2kXiKkAL/AgWyy72jAlz9GnL+qc45dLebdm3JgIA8z
         /KLhvrAEnZE19Z6//1oVNjCY5zkDEmt1AfHyjGV9sI1C7xDORHq5OYVMurEncLsdpH1q
         ABgPaRZIqX1Kedp+O2JcCpPg4bEUmMCdAQLrLe1WUN3XUOG3WS3vStKUFan/u5l+L42C
         7cOLMNe85VpTajvFx/+tcNAeQs6odDJSUUiXORHT4idFctaGEWN2CBOm+2C6QSwr38/6
         /FNg==
X-Gm-Message-State: AOJu0YzXGNHzmWLKNcWPn5XvaDEkckaaBMOWVGc53Jq/PVbEY9siUeIc
	j9iaPMeEJ5WYQa3Y5Udb7ubNaNHCf4D1kEK+mznUJkfJ/6ed+Q/Ehmu+3WUD0No=
X-Google-Smtp-Source: AGHT+IHtgqVc4dGRodfUI+5mrwigf1xOqOoq1XaZ686TNbdNzvm3dDCitVqVj7iIe7hadKDURImf9g==
X-Received: by 2002:a05:6870:a118:b0:22a:1ce4:c0cf with SMTP id m24-20020a056870a11800b0022a1ce4c0cfmr3722861oae.55.1711515037957;
        Tue, 26 Mar 2024 21:50:37 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:37 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 00/13] riscv: ASID-related and UP-related TLB flush enhancements
Date: Tue, 26 Mar 2024 21:49:41 -0700
Message-ID: <20240327045035.368512-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts uniprocessor kernel builds to use the same TLB
flushing code as SMP builds, to take advantage of batching and existing
range- and ASID-based TLB flush optimizations. It optimizes out IPIs and
SBI calls based on the online CPU count, which also covers the scenario
where SMP was enabled at build time but only one CPU is present/online.
A final optimization is to use single-ASID flushes wherever possible, to
avoid unnecessary TLB misses for kernel mappings.

This series has a semantic conflict with the AIA patches that are in
linux-next due to the removal of the third parameter of
riscv_ipi_set_virq_range(), which is called from imsic_ipi_domain_init()
in drivers/irqchip/irq-riscv-imsic-early.c. The resolution is to remove
the extra argument from the call site.

Here are some numbers from D1 which show the performance impact:

v6.9-rc1:
 System Benchmarks Partial Index              BASELINE       RESULT    INDEX
 Execl Throughput                                 43.0        198.5     46.2
 File Copy 1024 bufsize 2000 maxblocks          3960.0      73934.4    186.7
 File Copy 256 bufsize 500 maxblocks            1655.0      20242.6    122.3
 File Copy 4096 bufsize 8000 maxblocks          5800.0     197706.4    340.9
 Pipe Throughput                               12440.0     176974.2    142.3
 Pipe-based Context Switching                   4000.0      23626.8     59.1
 Process Creation                                126.0        449.9     35.7
 Shell Scripts (1 concurrent)                     42.4        544.4    128.4
 Shell Scripts (16 concurrent)                     ---         35.3      ---
 Shell Scripts (8 concurrent)                      6.0         71.6    119.3
 System Call Overhead                          15000.0     248072.6    165.4
                                                                    ========
 System Benchmarks Index Score (Partial Only)                          110.6

v6.9-rc1 + this patch series:
 System Benchmarks Partial Index              BASELINE       RESULT    INDEX
 Execl Throughput                                 43.0        196.8     45.8
 File Copy 1024 bufsize 2000 maxblocks          3960.0      71782.2    181.3
 File Copy 256 bufsize 500 maxblocks            1655.0      21269.4    128.5
 File Copy 4096 bufsize 8000 maxblocks          5800.0     199424.0    343.8
 Pipe Throughput                               12440.0     196468.6    157.9
 Pipe-based Context Switching                   4000.0      24261.8     60.7
 Process Creation                                126.0        459.0     36.4
 Shell Scripts (1 concurrent)                     42.4        543.8    128.2
 Shell Scripts (16 concurrent)                     ---         35.5      ---
 Shell Scripts (8 concurrent)                      6.0         71.7    119.6
 System Call Overhead                          15000.0     259415.2    172.9
                                                                    ========
 System Benchmarks Index Score (Partial Only)                          113.0

Changes in v6:
 - Move riscv_tlb_remove_ptdesc() definition to fix 32-bit build
 - Clarify the commit message for patch 3 based on ML discussion
 - Clarify the commit message for patch 8 based on ML discussion
 - Rebased on v6.9-rc1

Changes in v5:
 - Rebase on v6.8-rc1 + riscv/for-next (for the fast GUP implementation)
 - Add patch for minor refactoring in asm/pgalloc.h
 - Also switch to riscv_use_sbi_for_rfence() in asm/pgalloc.h
 - Leave use_asid_allocator declared in asm/mmu_context.h

Changes in v4:
 - Fix a possible race between flush_icache_*() and SMP bringup
 - Refactor riscv_use_ipi_for_rfence() to make later changes cleaner
 - Optimize kernel TLB flushes with only one CPU online
 - Optimize global cache/TLB flushes with only one CPU online
 - Merge the two copies of __flush_tlb_range() and rely on the compiler
   to optimize out the broadcast path (both clang and gcc do this)
 - Merge the two copies of flush_tlb_all() and rely on constant folding
 - Only set tlb_flush_all_threshold when CONFIG_MMU=y.

Changes in v3:
 - Fixed a performance regression caused by executing sfence.vma in a
   loop on implementations affected by SiFive CIP-1200
 - Rebased on v6.7-rc1

Changes in v2:
 - Move the SMP/UP merge earlier in the series to avoid build issues
 - Make a copy of __flush_tlb_range() instead of adding ifdefs inside
 - local_flush_tlb_all() is the only function used on !MMU (smpboot.c)

Samuel Holland (13):
  riscv: Flush the instruction cache during SMP bringup
  riscv: Factor out page table TLB synchronization
  riscv: Use IPIs for remote cache/TLB flushes by default
  riscv: mm: Broadcast kernel TLB flushes only when needed
  riscv: Only send remote fences when some other CPU is online
  riscv: mm: Combine the SMP and UP TLB flush code
  riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
  riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
  riscv: mm: Introduce cntx2asid/cntx2version helper macros
  riscv: mm: Use a fixed layout for the MM context ID
  riscv: mm: Make asid_bits a local variable
  riscv: mm: Preserve global TLB entries when switching contexts
  riscv: mm: Always use an ASID to flush mm contexts

 arch/riscv/Kconfig                   |  2 +-
 arch/riscv/errata/sifive/errata.c    |  5 ++
 arch/riscv/include/asm/errata_list.h | 12 ++++-
 arch/riscv/include/asm/mmu.h         |  3 ++
 arch/riscv/include/asm/pgalloc.h     | 32 ++++++------
 arch/riscv/include/asm/sbi.h         |  4 ++
 arch/riscv/include/asm/smp.h         | 15 +-----
 arch/riscv/include/asm/tlbflush.h    | 52 ++++++++-----------
 arch/riscv/kernel/sbi-ipi.c          | 11 +++-
 arch/riscv/kernel/smp.c              | 11 +---
 arch/riscv/kernel/smpboot.c          |  7 +--
 arch/riscv/mm/Makefile               |  5 +-
 arch/riscv/mm/cacheflush.c           |  7 +--
 arch/riscv/mm/context.c              | 23 ++++-----
 arch/riscv/mm/tlbflush.c             | 75 ++++++++--------------------
 drivers/clocksource/timer-clint.c    |  2 +-
 16 files changed, 114 insertions(+), 152 deletions(-)

-- 
2.43.1


