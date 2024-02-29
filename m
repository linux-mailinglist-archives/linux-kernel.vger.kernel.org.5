Return-Path: <linux-kernel+bounces-87671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056F886D7A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC9F283838
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59974BFE;
	Thu, 29 Feb 2024 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lxsEQRbq"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9976CBF4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248935; cv=none; b=aeBlPTgKlZnq+zdA8apl3p6ydSByqqmRWp62GxlbDC6IbTEjsxHeSB4ZX8Zsx7pegW6TDnE4wLbt+4+avktZRWYTyVMkvP7uF1cX2Wz/qoJIsVQNAzwdnQwGcICvKgGrSWevMe5Sy7nzQMFp5ftwK/mHU5OkaIzBxDUiRlLJrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248935; c=relaxed/simple;
	bh=L+uxNLgLcAP2So5TAbLvK0ywgwIMTRsVWysWfFLecXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IY4/JYezPC5YVYtwUYQUbzPWDbZi27SrpRWCITOGeip2jElgjv8dLhHlrFtdFWjJ8gybrjU/Ee7RIaeXQCZbefsagbtdWJiWfYb9yWVKS9fzYjONVQE97P55in3wJoF3Yi4+aYc6MhSsDaF+H6hlV5g2TanL8Mpa84n3Bb4fyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lxsEQRbq; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so971641b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248933; x=1709853733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYpxFJdLsUY33jWloX4oa7IMcbdSQ5C7SOjzy7kQJJw=;
        b=lxsEQRbq4jWVppJBeXye/BEUNzEMMrw2VHem1XegH0vkpOwIngviHi6BRbJ33+eZpR
         3fSdT7TH++x5YZJuaU+hF7VtV4VkczAKOTFlzexr9mHgaftEBU2KzTAjCoF8dLn+pich
         LzDGrOTislHpnsr2N8aF/YyIe5SZTizqGXcOQ57l+eS73i6T8sezV767zoYHdUU2/vek
         wdqNwCPj+8fuIqJw7mMmz8ONV0QcyvVZ1Gbmq09H9VwcVbuHAh1XRCsvE3yssWCO6ktq
         5dxRxYROcQpjGSIHtRmukfTRDZM4FjhKgyX7Hk+NChPSPYi+8J5tfmt+YWqNnSxBjxTc
         x/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248933; x=1709853733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYpxFJdLsUY33jWloX4oa7IMcbdSQ5C7SOjzy7kQJJw=;
        b=RR7lfA1i5kEMiJk/0Loq7usxYnAaJRcNYKXX44KsKky14cMCpiKDhD2LRKubkKLYuz
         MF0INwlRC0UIDVHDKd0B+DFpzIELhRxz5sw6BDSRefp1Oy1qv+dufBTJtrqJzE3e/6ZO
         2lv7P35oZgIVh/oDGR85YJvBXsrGi1QN/GiBVNKUcTW1A2B/k+epvRNDeOTYUZ0BzzBb
         Xoi3Ri2eiTe7BAzEFBzak3stfK2iauEtRWOxOAsiMDHzRqDqOSMLTasx2OI26oYoiScS
         ISarxGhKw2wHdU1Vjs8muP9EY81nZMg7irm3XC0CpnVg8XXWhscOblF8h0/ao+lJNRR7
         upmQ==
X-Gm-Message-State: AOJu0YwBgRhWrqToW1hCl3SPvqYqPDw7PUAs4qCabc9MYx4YTw5JkI65
	0AGeqbC6CkGZgXw3gYx/0E4dzZ6hLUv7MfofmvyRTWi/hVogzTJtzE+42DOQiaU=
X-Google-Smtp-Source: AGHT+IEbMzGg89JeXwrCbKoTrQtwzZydngrB60RIdlIeQk1Zbv0hmu3BVs2SCgNJATrXU3oE9uJ2wA==
X-Received: by 2002:a05:6808:1a83:b0:3c1:d0a2:9220 with SMTP id bm3-20020a0568081a8300b003c1d0a29220mr68801oib.24.1709248933079;
        Thu, 29 Feb 2024 15:22:13 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:12 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 00/13] riscv: ASID-related and UP-related TLB flush enhancements
Date: Thu, 29 Feb 2024 15:21:41 -0800
Message-ID: <20240229232211.161961-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing Alexandre Ghiti's "riscv: tlb flush improvements"
series[1], I noticed that most TLB flush functions end up as a call to
local_flush_tlb_all() when SMP is disabled. This series resolves that,
and also optimizes the scenario where SMP is enabled but only one CPU is
present or online. Along the way, I realized that we should be using
single-ASID flushes wherever possible, so I implemented that as well.

Here are some numbers from D1 (with SMP disabled) which show the
performance impact:

v6.8-rc6 + riscv/fixes + riscv/for-next:
 System Benchmarks Partial Index              BASELINE       RESULT    INDEX
 Execl Throughput                                 43.0        223.5     52.0
 File Copy 1024 bufsize 2000 maxblocks          3960.0      62563.4    158.0
 File Copy 256 bufsize 500 maxblocks            1655.0      17869.2    108.0
 File Copy 4096 bufsize 8000 maxblocks          5800.0     164915.1    284.3
 Pipe Throughput                               12440.0     161368.5    129.7
 Pipe-based Context Switching                   4000.0      22247.1     55.6
 Process Creation                                126.0        546.9     43.4
 Shell Scripts (1 concurrent)                     42.4        599.6    141.4
 Shell Scripts (16 concurrent)                     ---         39.3      ---
 Shell Scripts (8 concurrent)                      6.0         79.1    131.9
 System Call Overhead                          15000.0     246019.0    164.0
								    ========
 System Benchmarks Index Score (Partial Only)                          109.2

v6.8-rc6 + riscv/fixes + riscv/for-next + this patch series:
 System Benchmarks Partial Index              BASELINE       RESULT    INDEX
 Execl Throughput                                 43.0        223.1     51.9
 File Copy 1024 bufsize 2000 maxblocks          3960.0      71982.9    181.8
 File Copy 256 bufsize 500 maxblocks            1655.0      18436.9    111.4
 File Copy 4096 bufsize 8000 maxblocks          5800.0     184955.2    318.9
 Pipe Throughput                               12440.0     162622.9    130.7
 Pipe-based Context Switching                   4000.0      22082.5     55.2
 Process Creation                                126.0        546.4     43.4
 Shell Scripts (1 concurrent)                     42.4        598.1    141.1
 Shell Scripts (16 concurrent)                     ---         38.8      ---
 Shell Scripts (8 concurrent)                      6.0         78.6    131.0
 System Call Overhead                          15000.0     258529.3    172.4
								    ========
 System Benchmarks Index Score (Partial Only)                          112.8

[1]: https://lore.kernel.org/linux-riscv/20231030133027.19542-1-alexghiti@rivosinc.com/

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
 arch/riscv/include/asm/tlbflush.h    | 51 ++++++++-----------
 arch/riscv/kernel/sbi-ipi.c          | 11 +++-
 arch/riscv/kernel/smp.c              | 11 +---
 arch/riscv/kernel/smpboot.c          |  7 +--
 arch/riscv/mm/Makefile               |  5 +-
 arch/riscv/mm/cacheflush.c           |  7 +--
 arch/riscv/mm/context.c              | 23 ++++-----
 arch/riscv/mm/tlbflush.c             | 75 ++++++++--------------------
 drivers/clocksource/timer-clint.c    |  2 +-
 16 files changed, 114 insertions(+), 151 deletions(-)

-- 
2.43.1


